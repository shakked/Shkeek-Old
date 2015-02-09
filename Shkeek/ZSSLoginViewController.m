//
//  ZSSLoginViewController.m
//  Shkeek
//
//  Created by Zachary Shakked on 2/8/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

#import "ZSSLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ZSSCloudQuerier.h"
#import "UIAlertView+FrequentAlerts.h"

@interface ZSSLoginViewController ()

@end

@implementation ZSSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([PFUser currentUser]) {
        self.view.backgroundColor = [UIColor greenColor];
    } else {
        self.view.backgroundColor = [UIColor redColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginWithFacebookButtonPressed:(id)sender {
    [self loginThroughFacebook];
}

- (IBAction)loginWithTwitterButtonPressed:(id)sender {
    [self loginThroughTwitter];
}

- (void)loginThroughFacebook {
    [[ZSSCloudQuerier sharedQuerier] logInUserThroughFacebookWithCompletion:^(PFUser *user, NSError *error) {
        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                [UIAlertView showLoginErrorAlert];
            }

        } else {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
                [[ZSSCloudQuerier sharedQuerier] configureFacebookUserDataWithCompletion:^(NSError *error) {
                    if (!error) {
                        [self beginOnboarding];
                    } else {
                        [UIAlertView showNoConnectionErrorAlert];
                    }
                }];
            } else {
                NSLog(@"User with facebook logged in!");
            }
        }
    }];
}

- (void)loginThroughTwitter {
    [[ZSSCloudQuerier sharedQuerier] logInUserThroughTwitterWithCompletion:^(PFUser *user, NSError *error) {
        PFUser *currentUser = [PFUser currentUser];
        
        NSLog(@"currentUser.authData: %@",[currentUser valueForKey:@"authData"]);
        
        NSDictionary *authData = [[PFUser currentUser] valueForKey:@"authData"];
        NSLog(@"authData: %@", authData);
        
        
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            if (!error) {
                [UIAlertView showLoginErrorAlert];
            }
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in with Twitter!");
        } else {
            NSLog(@"User logged in with Twitter!");
        }
        
    }];
}

- (void)beginOnboarding {
    NSLog(@"Begin Onboarding");
}

- (void)showLoginError {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                    message:@"Error logging user in."
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Dismiss", nil];
    [alert show];
}



@end
