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

@interface ZSSLoginViewController ()

@end

@implementation ZSSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
                [self showLoginError];
            }

        } else {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
                [[ZSSCloudQuerier sharedQuerier] configureFacebookUserDataWithCompletion:^(NSError *error) {
                    if (!error) {
                        [self beginOnboarding];
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                                        message:@"Error retrieving user data"
                                                                       delegate:nil
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:@"Dismiss", nil];
                        [alert show];
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
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
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
