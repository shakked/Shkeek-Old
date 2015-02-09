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
#import <AFNetworking/AFNetworking.h>
#import "ZSSLocationQuerier.h"

static NSString * const BaseURLString = @" https://api.parse.com";

@interface ZSSCloudQuerier () {
    NSString *parseApplicationId;
    NSString *parseRestAPIKey;
}

@end

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

- (void)getTopGroupsWithCompletion:(void (^)(NSArray *, NSError *))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:parseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:parseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    NSDictionary *parameters = @{@"order" : @"-followerCount",
                                 @"limit" : @10};
    
    [manager GET:@"https://api.parse.com/1/classes/ZSSGroup" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject[@"results"], nil);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil,error);
    }];
}

- (void)getLocalTopGroupsWithCompletion:(void (^)(NSArray *, NSError *))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:parseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:parseRestAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [[ZSSLocationQuerier sharedQuerier] findCurrentLocaitonWithCompletion:^(CLLocation *location, NSError *error) {
        if (!error) {
            NSDictionary *jsonDictionary = @{@"location" : @{@"$nearSphere" : @{@"__type": @"GeoPoint",
                                                                                @"latitude": [NSNumber numberWithFloat:location.coordinate.latitude],
                                                                                @"longitude": [NSNumber numberWithFloat:location.coordinate.longitude]},
                                                             @"$maxDistanceInMiles" : @100.0
                                                             }
                                             };
            
            NSString *json = [self getJSONfromDictionary:jsonDictionary];
            NSDictionary *parameters = @{@"where" : json,
                                         @"order" : @"-followerCount",
                                         @"limit" : @10};
            
            [manager GET:@"https://api.parse.com/1/classes/ZSSGroup" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                completion(responseObject[@"results"], nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                completion(nil,error);
            }];
            
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];

}


- (NSString *)getJSONfromDictionary:(NSDictionary *)jsonDictionary {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:&error];
    if (!jsonData) {
        [self throwInvalidJsonDataException];
    }
    
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

- (void)throwInvalidJsonDataException {
    @throw [NSException exceptionWithName:@"jsonDataException"
                                   reason:@"Failed to create NSData with provided json dictionary"
                                 userInfo:nil];
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        [self setKeys];
    }
    return self;
}

- (void)setKeys {
    NSString *keyPath = [[NSBundle mainBundle] pathForResource:@"Keys" ofType:@"plist"];
    NSDictionary *keyDict = [NSDictionary dictionaryWithContentsOfFile:keyPath];
    parseApplicationId = keyDict[@"ParseApplicationID"];
    parseRestAPIKey = keyDict[@"ParseRestAPIKey"];
}


- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use + [ZSSDownloader sharedDownloader]"
                                 userInfo:nil];
    return nil;
}

@end
