//
//  HPHTTPStubsDemoTests.m
//  HPHTTPStubsDemoTests
//
//  Created by Alexander Perepelitsyn on 6/11/13.
//  Copyright (c) 2013 Alexander Perepelitsyn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AsyncSenTestCase.h"
#import "OHHTTPStubs.h"
#import "ViewController.h"

@interface HPHTTPStubsDemoTests : AsyncSenTestCase
{
    ViewController *sut;
}

@end

@implementation HPHTTPStubsDemoTests

- (void)setUp
{
    [super setUp];
    
    sut = [[ViewController alloc] init];
}

- (void)tearDown
{
    sut = nil;
    // Remove request handler(s) here
    
    [super tearDown];
}

- (void)testSuccessCase
{
    // ARRANGE
    NSURL *url = [NSURL URLWithString:@"http://blah"];
    
    // Instruct OHHTTPStubs to return stubbed response from response.json
    
    // ACT
    [sut downloadFromURL:url completionBlock:^(id data, NSError *error) {
        [self notify:AsyncSenTestCaseStatusSucceeded];
        STAssertNil(error, @"Should not receive error.");
    }];
    
    [self waitForTimeout:3.0];
}

- (void)testErrorCase
{
    // ARRANGE
    NSURL *url = [NSURL URLWithString:@"http://blah"];
    
    // Instruct OHHTTPStubs to return error with domain 'Test Error' code 3333
    
    // ACT
    [sut downloadFromURL:url completionBlock:^(id data, NSError *error) {
        [self notify:AsyncSenTestCaseStatusFailed];
        STAssertNotNil(error, @"Should receive error.");
        STAssertEqualObjects(@"Test Error", [error domain], @"Should receive error with Test Error domain.");
        STAssertEquals((NSInteger)3333, [error code], @"Should receive error with code 3333.");
    }];
    
    [self waitForTimeout:3.0];
}

- (void)testSuccessCaseUsingInternetConnection // Integration test
{
    // ARRANGE
    NSString *urlString = @"http://itunes.apple.com/search?term=harry&country=us&entity=movie";
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Instruct OHHTTPStubs to do no stubbing
    
    // ACT
    [sut downloadFromURL:url completionBlock:^(id data, NSError *error) {
        [self notify:AsyncSenTestCaseStatusSucceeded];
        STAssertNil(error, @"Should not receive error.");
        STAssertNotNil(data, @"Should receive data.");
    }];
    
    [self waitForTimeout:3.0];
}

@end
