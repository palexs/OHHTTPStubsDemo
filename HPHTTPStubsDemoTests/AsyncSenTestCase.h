//
//  AsyncSenTestCase.h
//  Tunehog (C) R&R Music
//
//  Created by Sergei Merenkov on 07.12.12.
//
//

#import <SenTestingKit/SenTestingKit.h>

typedef enum {
    AsyncSenTestCaseStatusUnknown = 0,
    AsyncSenTestCaseStatusWaiting,
    AsyncSenTestCaseStatusSucceeded,
    AsyncSenTestCaseStatusFailed,
    AsyncSenTestCaseStatusCancelled,
} AsyncSenTestCaseStatus;

@interface AsyncSenTestCase : SenTestCase

- (void)waitForTimeout:(NSTimeInterval)timeout;
- (void)notify:(AsyncSenTestCaseStatus)status;

@property (nonatomic, assign) BOOL notified;
@property (nonatomic, assign) AsyncSenTestCaseStatus notifiedStatus;

@end
