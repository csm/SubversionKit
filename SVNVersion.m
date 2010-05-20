//
//  SVNVersion.m
//  SubversionKit
//
//  Created by Casey Marshall on 5/20/10.
//  Copyright 2010 Modal Domains. All rights reserved.
//

#import "SVNVersion.h"

@implementation SVNVersion

- (id) init
{
    if (self = [super init])
    {
        ver = svn_client_version();
    }
    return self;
}

+ (SVNVersion *) version
{
    return [[SVNVersion new] autorelease];
}

- (NSInteger) major
{
    return ver->major;
}

- (NSInteger) minor
{
    return ver->minor;
}

- (NSInteger) patch
{
    return ver->patch;
}

- (NSString *) tag
{
    return [NSString stringWithFormat: @"%s", ver->tag];
}

- (NSString *) description
{
    return [NSString stringWithFormat: @"%d.%d.%d (%@)", self.major,
            self.minor, self.patch, self.tag];
}

@end
