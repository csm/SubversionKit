//
//  SubversionRevision.m
//  SubversionKit
//
//  Created by Casey Marshall on 5/20/10.
//  Copyright 2010 Modal Domains. All rights reserved.
//

#import "SVNRevision.h"


@implementation SVNRevision

- (id) initWithKind: (SVNRevisionKind) aKind
{
    return [self initWithKind: aKind
                       number: -1
                         date: nil];
}

- (id) initWithKind: (SVNRevisionKind) aKind
             number: (SVNRevisionNumber) aNumber
{
    return [self initWithKind: aKind
                       number: aNumber
                         date: nil];
}

- (id) initWithKind: (SVNRevisionKind) aKind
               date: (NSDate *) aDate
{
    return [self initWithKind: aKind
                       number: -1
                         date: aDate];
}

- (id) initWithKind:(SVNRevisionKind)aKind
             number: (SVNRevisionNumber) aNumber
               date: (NSDate *) aDate
{
    if (self = [super init])
    {
        self.kind = aKind;
        self.number = aNumber;
        self.date = aDate;
    }
    return self;
}

- (SVNRevisionKind) kind
{
    return (SVNRevisionKind) revision.kind;
}

- (void) setKind: (SVNRevisionKind) kind
{
    revision.kind = (enum svn_opt_revision_kind) kind;
}

- (SVNRevisionNumber) number
{
    return revision.value.number;
}

- (void) setNumber: (SVNRevisionNumber) number
{
    revision.value.number = number;
}

- (NSDate *) date
{
    return [NSDate dateWithTimeIntervalSince1970: apr_time_sec(revision.value.date)];
}

- (void) setDate: (NSDate *) date
{
    NSTimeInterval interval = 0;
    if (date != nil)
        interval = [date timeIntervalSince1970];
    revision.value.date = apr_time_from_sec(interval);
}

- (BOOL) isEqualToRevision: (SVNRevision *) that
{
    return (self.kind == that.kind
            && self.number == that.number
            && [self.date isEqual: that.date]);
}

- (BOOL) isEqual: (NSObject *) that
{
    if (that == nil || ![that isKindOfClass: [SVNRevision class]])
        return NO;
    
    return [self isEqualToRevision: (SVNRevision *) that];
}

static NSString *
kindDesc(SVNRevisionKind kind)
{
    switch (kind)
    {
        case SVNRevisionKindUnspecified:
            return @"Revision Unspecified";
        case SVNRevisionKindNumber:
            return @"Revision Number";
        case SVNRevisionKindDate:
            return @"Revision Date";
        case SVNRevisionKindCommitted:
            return @"Committed Revision";
        case SVNRevisionKindPrevious:
            return @"Previous Revision";
        case SVNRevisionKindBase:
            return @"Base Revision";
        case SVNRevisionKindWorking:
            return @"Working Revision";
        case SVNRevisionKindHead:
            return @"Head Revision";
    }
    return @"";
}

- (NSString *) description
{
    return [NSString stringWithFormat: @"%@ %d %@", kindDesc(self.kind),
            self.number, self.date];
}

- (void)dealloc {
    [super dealloc];
}


@end
