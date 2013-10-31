//
//  MNScriptLoader.h
//  MobileNode
//
//  Created by Kevin Whinnery on 10/12/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface MNScriptLoader : NSObject

// Initialize by loading a script from the app bundle.  By default, we'll look for "mnbundle".
// Omit the ".js" extension
- (id)initFromBundle:(NSString*)filenameOrNil;

// Initialize dev mode, which will start a socket.io client
- (void)developOnHost:(NSString*)host port:(int)port;

// Send a message back over the socket for logging
-(void)log:(NSString*)message;

@end
