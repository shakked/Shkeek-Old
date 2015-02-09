//
//  testZSSCloudQuerier.m
//  Shkeek
//
//  Created by Zachary Shakked on 2/9/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZSSCloudQuerier.h"

@interface testZSSCloudQuerier : XCTestCase

@end

@implementation testZSSCloudQuerier

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetTopGroups {
    XCTestExpectation *expectaion = [self expectationWithDescription:@"topGroups"];
    [[ZSSCloudQuerier sharedQuerier] getTopGroupsWithCompletion:^(NSArray *groups, NSError *error) {
        XCTAssertNil(error);
        XCTAssert(groups);
        for (NSDictionary *group in groups) {

        }
        [expectaion fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        
    }];
}

- (void)testGetTopLocalGroups {
    XCTestExpectation *expectaion = [self expectationWithDescription:@"topGroups"];
    [[ZSSCloudQuerier sharedQuerier] getLocalTopGroupsWithCompletion:^(NSArray *groups, NSError *error) {
        XCTAssertNil(error);
        XCTAssert(groups);
        for (NSDictionary *group in groups) {
            
        }
        [expectaion fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
