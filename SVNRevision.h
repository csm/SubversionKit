//
//  SubversionRevision.h
//  SubversionKit
//
//  Created by Casey Marshall on 5/20/10.
//  Copyright 2010 Modal Domains. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <svn_opt.h>

typedef long int SVNRevisionNumber;

typedef enum SVNRevisionKind
{
    SVNRevisionKindUnspecified = svn_opt_revision_unspecified,
    SVNRevisionKindNumber = svn_opt_revision_number,
    SVNRevisionKindDate = svn_opt_revision_date,
    SVNRevisionKindCommitted = svn_opt_revision_committed,
    SVNRevisionKindPrevious = svn_opt_revision_previous,
    SVNRevisionKindBase = svn_opt_revision_base,
    SVNRevisionKindWorking = svn_opt_revision_working,
    SVNRevisionKindHead = svn_opt_revision_head
} SVNRevisionKind;

@interface SVNRevision : NSObject
{
    svn_opt_revision_t revision;
}

@property (assign) SVNRevisionKind kind;
@property (assign) SVNRevisionNumber number;
@property (assign) NSDate *date;

- (id) initWithKind: (SVNRevisionKind) aKind;
- (id) initWithKind: (SVNRevisionKind) aKind
             number: (SVNRevisionNumber) aNumber;
- (id) initWithKind: (SVNRevisionKind) aKind
               date: (NSDate *) aDate;
- (id) initWithKind:(SVNRevisionKind)aKind
             number: (SVNRevisionNumber) aNumber
               date: (NSDate *) aDate;

@end
