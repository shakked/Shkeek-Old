//
//  AppDelegate.m
//  Shkeek
//
//  Created by Zachary Shakked on 2/8/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ZSSWelcomeViewController.h"
#import "ZSSFeedTableViewController.h"
#import "ZSSGroupsCollectionViewController.h"
#import "ZSSProfileTableViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [self configureParse];
    
    if ([PFUser currentUser]) {
        UITabBarController *tbc = [[UITabBarController alloc] init];
        ZSSFeedTableViewController *ftvc = [[ZSSFeedTableViewController alloc] init];
        UINavigationController *feedNav = [[UINavigationController alloc] initWithRootViewController:ftvc];
        UITabBarItem *feedTabItem = [[UITabBarItem alloc] init];
        feedTabItem.image = [UIImage imageNamed:@"IceCreamIcon"];
        feedTabItem.title = @"Updates";
        ftvc.tabBarItem = feedTabItem;
        
        ZSSGroupsCollectionViewController *gtvc = [[ZSSGroupsCollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewLayout ];
        UINavigationController *groupsNav = [[UINavigationController alloc] initWithRootViewController:gtvc];
        UITabBarItem *groupsTabItem = [[UITabBarItem alloc] init];
        groupsTabItem.image = [UIImage imageNamed:@"GroupIcon"];
        groupsTabItem.title = @"Groups";
        gtvc.tabBarItem = groupsTabItem;
        
        ZSSProfileTableViewController *ptvc = [[ZSSProfileTableViewController alloc] init];
        UINavigationController *profileNav = [[UINavigationController alloc] initWithRootViewController:ptvc];
        UITabBarItem *profileTabItem = [[UITabBarItem alloc] init];
        profileTabItem.image = [UIImage imageNamed:@"ProfileIcon"];
        profileTabItem.title = @"Profile";
        ptvc.tabBarItem = profileTabItem;
        
        tbc.viewControllers = @[feedNav, groupsNav, profileNav];
        
        self.window.rootViewController = tbc;
    } else {
        ZSSWelcomeViewController *wvc = [[ZSSWelcomeViewController alloc] init];
        self.window.rootViewController = wvc;
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)configureParse {
    NSString *keyPath = [[NSBundle mainBundle] pathForResource:@"Keys" ofType:@"plist"];
    NSDictionary *keyDict = [NSDictionary dictionaryWithContentsOfFile:keyPath];
    NSString *parseApplicationId = keyDict[@"ParseApplicationID"];
    NSString *parseClientKey = keyDict[@"ParseClientKey"];
    [Parse setApplicationId:parseApplicationId
                  clientKey:parseClientKey];
    [PFFacebookUtils initializeFacebook];
    [PFTwitterUtils initializeWithConsumerKey:@"Iv6gM5QxuXV6TYddNjHJMLYLw"
                               consumerSecret:@"C8twO0ik7o5pfHy5HGa5UA60qMsq3bNlZsKdmOwVVWqkQccqXp"];
}

@end
