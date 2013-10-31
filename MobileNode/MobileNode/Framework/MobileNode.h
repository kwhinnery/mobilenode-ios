//
//  MobileNode.h
//  MobileNode
//
//  Created by Kevin Whinnery on 9/27/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface MobileNode : NSObject

// Create a mobilenode execution environment with default options
+(void)go;

// Create a mobilenode execution environment from the file in the bundle
+(void)go:(NSString*)filename;

// Set up a development environment with source code loaded from a socket.io server
+(void)developOnHost:(NSString*)host port:(int)port;

// Reload the JSContext and run the given app
+(void)reload:(NSString*)js;

// Define a function that can be called from JavaScript
+(void)defineFunction:(NSString*)functionName withBlock:(id(^)(NSDictionary*))block;

// Allow native code to invoke a function in JavaScript
+(JSValue*)callFunction:(NSString*)functionName withData:(NSDictionary*)data;

// Log a message to the console (dev mode)
+(void)log:(NSString*)message;

@end
