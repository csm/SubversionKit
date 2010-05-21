//
//  AsynchronousInvocation.m
//  SubversionKit
//
//  Created by Casey Marshall on 5/21/10.
//  Copyright 2010 Modal Domains. All rights reserved.
//

#import "AsynchronousInvocation.h"

@interface AsynchronousInvocation(run)
- (void) run: (id) arg;
@end

@implementation AsynchronousInvocation(run)

- (void) run: (id) arg
{
    [lock lock];
    state = AsynchronousInvocationRunning;
    [invocation invoke];
    state = AsynchronousInvocationCompleted;
    [lock unlock];
}

@end


@implementation AsynchronousInvocation

- (id) initWithInvocation: (NSInvocation *) anInvocation
                 delegate: (NSObject<AsynchronousInvocationDelegate> *) aDelegate
{
    if (self = [super init])
    {
        state = AsynchronousInvocationNotStarted;
        invocation = [anInvocation retain];
        delegate = [aDelegate retain];
        lock = [[NSLock alloc] init];
    }
    return self;
}

- (void) beginInvocation
{
    [NSThread detachNewThreadSelector: @synthesize(run:)
                             toTarget: self
                           withObject: nil];
    [[NSRunLoop currentRunLoop] performSelector: @selector(runOne:)
                                         target: self
                                       argument: nil
                                          order: 1
                                          modes: [NSArray arrayWithObject: NSDefaultRunLoopMode]];
}

- (void) runOne: (id) arg
{
    if ([lock tryLock])
    {
        if (state == AsynchronousInvocationCompleted)
        {
            [delegate invocationDidReturn: invocation];
            return;
        }
    }
    
    // run me again.
    [[NSRunLoop currentRunLoop] performSelector: @selector(runOne:)
                                         target: self
                                       argument: nil
                                          order: 1
                                          modes: [NSArray arrayWithObject: NSDefaultRunLoopMode]];
}

- (void) dealloc
{
    [invocation release];
    [delegate release];
    [lock release];
}

@end
