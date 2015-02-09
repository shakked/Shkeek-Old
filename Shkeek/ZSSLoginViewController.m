//
//  ZSSLoginViewController.m
//  Shkeek
//
//  Created by Zachary Shakked on 2/8/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

#import "ZSSLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ZSSLoginViewController ()

@end

@implementation ZSSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.center = self.view.center;
    [self.view addSubview:loginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpWithFacebookButtonPressed:(id)sender {
    
}

- (IBAction)signUpWithInstagramButtonPressed:(id)sender {
    
}

- (IBAction)signUpWithTwitterButtonPressed:(id)sender {
    
}

@end
