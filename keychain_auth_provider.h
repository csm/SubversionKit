/*
 *  keychain_auth_provider.h
 *  SubversionKit
 *
 *  Created by Casey Marshall on 5/20/10.
 *  Copyright 2010 Modal Domains. All rights reserved.
 *
 */

#ifndef __keychain_auth_provider_h__
#define __keychain_auth_provider_h__

#include <Security/Security.h>
#include <svn_auth.h>

svn_auth_provider_t SVNGetKeychainAuthProvider();

#endif /* __keychain_auth_provider_h__ */