//
//  ZSSWelcomeChildViewController.m
//  Shkeek
//
//  Created by Zachary Shakked on 2/8/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

#import "ZSSWelcomeChildViewController.h"

@interface ZSSWelcomeChildViewController ()

@end

@implementation ZSSWelcomeChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0
                                                green:arc4random()%255/255.0
                                                 blue:arc4random()%255/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
