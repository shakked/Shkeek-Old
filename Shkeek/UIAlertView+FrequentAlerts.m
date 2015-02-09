//
//  UIAlertView+FrequentAlerts.m
//  Shkeek
//
//  Created by Zachary Shakked on 2/8/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

#import "UIAlertView+FrequentAlerts.h"

@implementation UIAlertView (FrequentAlerts)

- (void)showLoginErrorAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                    message:@"Error logging user in."
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Dismiss", nil];
    [alert show];
}

- (void)showNoConnectionErrorAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                                    message:@"Error connecting to the internet"
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Dismiss", nil];
    [alert show];
}

@end
