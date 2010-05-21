/*
 *  SVNAuthenticationDelegate.h
 *  SubversionKit
 *
 *  Created by Casey Marshall on 5/20/10.
 *  Copyright 2010 Modal Domains. All rights reserved.
 *
 */


@protocol SVNAuthenticationDelegate

/**
 * Called to fetch a username and password.
 */
- (void) getUsername: (char **) usernamePtr
            password: (char **) passwordPtr;

@end