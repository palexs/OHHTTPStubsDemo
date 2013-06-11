//
//  AsyncSenTestCase.m
//  Tunehog (C) R&R Music
//
//  Created by Sergei Merenkov on 07.12.12.
//
//

#import "AsyncSenTestCase.h"

@interface AsyncSenTestCase()

@property (nonatomic, retain) NSDate *loopUntil;

@end

@implementation AsyncSenTestCase

- (void)waitForTimeout:(NSTimeInterval)timeout
{
    self.notified = NO;
    self.loopUntil = [NSDate dateWithTimeIntervalSinceNow:timeout];
    
    while (!self.notified && [self.loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:self.loopUntil];
    }
}

- (void)notify:(AsyncSenTestCaseStatus)status
{
    self.notifiedStatus = status;
    // self.notified must be set at the last of this method
    self.notified = YES;
}

@end
