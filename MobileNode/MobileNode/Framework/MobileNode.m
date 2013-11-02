//
//  MobileNode.m
//  MobileNode
//
//  Created by Kevin Whinnery on 9/27/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "MobileNode.h"
#import "MNScriptLoader.h"

// Standard Library modules
#import "MNAlertModule.h"
#import "MNLoggerModule.h"

@implementation MobileNode

// Our single MobileNode environment
static MobileNode *singleton;

+(void)initialize
{
    if (!singleton) {
        singleton = [[MobileNode alloc] init];
    }
    singleton.functions = [[NSMutableDictionary alloc] init];
    singleton.onLoadBlocks = [[NSMutableArray alloc] init];
}

// Initialize from zero
+(void)start:(NSString*)filename loadScriptFromBundle:(BOOL)load
{
    // Create a new context
    singleton.context = [[JSContext alloc] init];
    
    // Set up an exception handler
    singleton.context.exceptionHandler =  ^void(JSContext *context, JSValue *exception) {
        NSDictionary *d = [exception toDictionary];
        if (d) {
            [MNLoggerModule log:[NSString stringWithFormat:@"Exception on line %@ of browserified script: %@",
                                 [d objectForKey:@"line"],
                                 exception]
                          level:@"ERROR"];
            
            [MNLoggerModule log:[NSString stringWithFormat:@"Stack: %@", [d objectForKey:@"stack"]]
                          level:@"ERROR"];
        }
    };
    
    // Define call out from JavaScript to native code
    singleton.context[@"__callNativeFunction"] = ^(NSString* name, NSDictionary* data) {
        id (^cb)(NSDictionary*) =  [singleton.functions objectForKey:name];
        if (cb) {
            id val = cb(data);
            return val;
        }
        else {
            return (id) nil;
        }
    };
    
    // Bootstrap JS environment
    NSString *bootstrapPath = [[NSBundle mainBundle] pathForResource:@"mnbootstrap"
                                                              ofType:@"js"];
    
    NSError *err;
    NSString *bootstrap = [NSString stringWithContentsOfFile:bootstrapPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:&err];
    // Handle any error loading the js code
    if (err) {
        NSLog(@"There was a problem loading the script from the bundle: %@", err);
    } else {
        JSValue *bootstrapResult = [singleton.context evaluateScript:bootstrap];
        NSLog(@"[MobileNode]: bootstrapped with result (undefined expected): %@", bootstrapResult);
    }
    
    // Load native standard library functions
    [MNAlertModule init];
    [MNLoggerModule init];
    
    // Initialize script loader
    if (load) {
        singleton.loader = [[MNScriptLoader alloc] initFromBundle:filename];
    } else {
        singleton.loader = [[MNScriptLoader alloc] init];
    }
}

// Start with default options
+(void)go
{
    [self start:@"mnbundle" loadScriptFromBundle:YES];
}

// Start with a file from the bundle
+(void)go:(NSString *)filename
{
    [self start:filename loadScriptFromBundle:YES];
}

// Set up dev server, overriding default script loader
+(void)developOnHost:(NSString *)host port:(int)port
{
    [self start:nil loadScriptFromBundle:NO];
    [singleton.loader developOnHost:host port:port];
}

// create a new context and run the given application JS
+(void)reload:(NSString*)js
{
    // Fire event to notify modules that script will be reloading
    for (id (^onloadCb)(NSString*) in singleton.onLoadBlocks) {
        if (onloadCb) {
            onloadCb(js);
        }
    }
    
    // Eval app code
    [singleton.context evaluateScript:js];
}

// Log a message back to the JS console
+(void)log:(NSString *)message
{
    [singleton.loader log:message];
}

// Define a function that can be called from JavaScript
+(void)defineFunction:(NSString *)functionName withBlock:(id (^)(NSDictionary *))block
{
    [singleton.functions setObject:block forKey:functionName];
}

// Call a function defined in JavaScript
+(JSValue*)callFunction:(NSString *)functionName withData:(NSDictionary *)data
{
    NSArray *publishArgs = @[functionName, data];
    JSValue *call = singleton.context[@"__callFunction"];
    return [call callWithArguments:publishArgs];
}

// Register lifecycle handler for when a script is about to load
+(void)scriptWillLoad:(void (^)(NSString* src))block
{
    [singleton.onLoadBlocks addObject:block];
}

@end
