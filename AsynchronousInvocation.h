//
//  AsynchronousInvocation.h
//  SubversionKit
//
//  Created by Casey Marshall on 5/21/10.
//  Copyright 2010 Modal Domains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <semaphore.h>

@protocol AsynchronousInvocationDelegate

- (void) invocationDidReturn: (NSInvocation *) invocation;

@end

typedef enum AsynchronousInvocationState
{
    AsynchronousInvocationNotStarted,
    AsynchronousInvocationRunning,
    AsynchronousInvocationCompleted
} AsynchronousInvocationState;

@interface AsynchronousInvocation : NSObject
{
    NSInvocation *invocation;
    NSObject<AsynchronousInvocationDelegate> *delegate;
    NSThread *invocationThread;
    NSRecursiveLock *lock;
    AsynchronousInvocationState state;
}

- (id) initWithInvocation: (NSInvocation *) anInvocation
                 delegate: (NSObject<AsynchronousInvocationDelegate> *) aDelegate;

- (void) beginInvocation;
- (void) runOne: (id) arg;

@end
