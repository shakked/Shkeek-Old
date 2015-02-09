//
//  ZSSCloudQuerier.m
//  Shkeek
//
//  Created by Zachary Shakked on 2/8/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

#import "ZSSCloudQuerier.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>


@implementation ZSSCloudQuerier

+ (instancetype)sharedQuerier {
    static ZSSCloudQuerier *sharedQuerier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedQuerier = [[self alloc] initPrivate];
    });
    return sharedQuerier;
}

- (void)logInUserThroughFacebookWithCompletion:(void (^)(PFUser *, NSError *))completionBlock {
    NSArray *permissions = @[@"email"];
    [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
        completionBlock(user, error);
    }];
    
}

- (void)configureFacebookLinkedUser:(PFUser *)user withCompletion:(void (^)(NSError *))completionBlock {
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            NSString *location = userData[@"location"][@"name"];
            NSString *gender = userData[@"gender"];
            NSString *birthday = userData[@"birthday"];
            NSString *relationship = userData[@"relationship_status"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            user[@"displayName"] = name;
            [user saveInBackground];
            completionBlock(error);
        }
    }];
}

- (void)logInUserThroughTwitterWithCompletion:(void (^)(PFUser *, NSError *))completionBlock {
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        completionBlock(user, error);
    }];
}

- (void)configureTwitterUserData {
    PFUser *currentUser = [PFUser currentUser];
    currentUser[@"displayName"] = [[[currentUser valueForKey:@"authData"] valueForKey:@"twitter"] valueForKey:@"screen_name"];
    [currentUser saveInBackground];
    NSLog(@"currentUser.displayName: %@", currentUser[@"displayName"]);
}


- (instancetype)initPrivate {
    self = [super init];
    if (self) {

    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use + [ZSSDownloader sharedDownloader]"
                                 userInfo:nil];
    return nil;
}

@end
