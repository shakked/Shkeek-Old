//
//  ZSSCloudQuerier.h
//  Shkeek
//
//  Created by Zachary Shakked on 2/8/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ZSSCloudQuerier : NSObject

+ (instancetype)sharedQuerier;

- (void)logInUserThroughFacebookWithCompletion:(void (^)(PFUser *, NSError *))completionBlock;
- (void)configureFacebookLinkedUser:(PFUser *)user withCompletion:(void (^)(NSError *))completionBlock;

- (void)logInUserThroughTwitterWithCompletion:(void (^)(PFUser *, NSError *))completionBlock;
- (void)configureTwitterUserData;

@end
