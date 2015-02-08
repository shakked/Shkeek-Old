//
//  ZSSWelcomeViewController.m
//  
//
//  Created by Zachary Shakked on 2/8/15.
//
//

#import "ZSSWelcomeViewController.h"
#import "ZSSWelcomeChildViewController.h"

@interface ZSSWelcomeViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation ZSSWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:    UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];

    self.pageViewController.dataSource = self;
    self.pageViewController.view.frame = self.view.bounds;
    
    ZSSWelcomeChildViewController *cvc1 = [[ZSSWelcomeChildViewController alloc] init];
    ZSSWelcomeChildViewController *cvc2 = [[ZSSWelcomeChildViewController alloc] init];
    ZSSWelcomeChildViewController *cvc3 = [[ZSSWelcomeChildViewController alloc] init];
    ZSSWelcomeChildViewController *cvc4 = [[ZSSWelcomeChildViewController alloc] init];
    
    NSArray *viewControllers = @[cvc1, cvc2, cvc3, cvc4];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self.view addSubview:self.pageViewController.view];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
