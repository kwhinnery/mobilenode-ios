//
//  MNScriptLoader.m
//  MobileNode
//
//  Created by Kevin Whinnery on 10/12/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import "MobileNode.h"
#import "MNLoggerModule.h"
#import "MNScriptLoader.h"
#import "SRWebSocket.h"

@interface MNScriptLoader() <SRWebSocketDelegate>

@end

@implementation MNScriptLoader {
    SRWebSocket *webSocket;
    NSString *src;
}

// Initialize with source from app bundle
- (id)initFromBundle:(NSString*)filenameOrNil
{
    self = [super init];
    if (self) {
        
        if (!filenameOrNil) {
            filenameOrNil = @"mnbundle";
        }
        
        // First, try to load script from bundle
        NSString *srcPath = [[NSBundle mainBundle] pathForResource:filenameOrNil
                                                            ofType:@"js"];
        
        NSError *err;
        src = [NSString stringWithContentsOfFile:srcPath
                                        encoding:NSUTF8StringEncoding
                                           error:&err];
        
        // Handle any error loading the js code
        if (err) {
            NSLog(@"There was a problem loading the app script from the bundle: %@", err);
        } else {
            [MobileNode reload:src];
        }
    }
    return self;
}

// Set up a socket.io server which will grab the latest src from a server
- (void)developOnHost:(NSString *)host port:(int)port
{
    webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:8080"]];
    webSocket.delegate = self;
    [webSocket open];
}

// Log a message back over the console
-(void)log:(NSString *)message
{
    if (webSocket) {
        [webSocket send:message];
    }
}

// Delegate methods
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    src = message;
    [MobileNode reload:src];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"socket communication error: %@", error);
}

@end
