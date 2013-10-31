//
//  MNLoggerModule.m
//  MobileNodeGame
//
//  Created by Kevin Whinnery on 10/13/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNLoggerModule.h"
#import "MobileNode.h"

@implementation MNLoggerModule

+(void)log:(NSString*)msg level:(NSString*)levelOrNil
{
    if (!levelOrNil) {
        levelOrNil = @"INFO";
    }
    NSString *message = [NSString stringWithFormat:@"[%@]: %@", levelOrNil, msg];
    NSLog(@"%@", message);
    [MobileNode log:message];
}

+(void)init
{
    // Define a function, callable from JS, which logs a message to the console
    [MobileNode defineFunction:@"log" withBlock:(id)^(NSDictionary* data) {
        [MNLoggerModule log:[data objectForKey:@"message"] level:[data objectForKey:@"level"]];
    }];
}

@end
