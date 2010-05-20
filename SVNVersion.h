//
//  SVNVersion.h
//  SubversionKit
//
//  Created by Casey Marshall on 5/20/10.
//  Copyright 2010 Modal Domains. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <svn_client.h>

@interface SVNVersion : NSObject
{
    const svn_version_t *ver;
}

+ (SVNVersion *) version;

@property (readonly) NSInteger major;
@property (readonly) NSInteger minor;
@property (readonly) NSInteger patch;
@property (readonly) NSString *tag;

@end
