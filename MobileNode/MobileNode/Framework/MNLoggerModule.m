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

+(void)init
{
    // Define a function, callable from JS, which logs a message to the console
    [MobileNode defineFunction:@"log" withBlock:(id)^(NSDictionary* data) {
        NSString *message = [NSString stringWithFormat:@"[%@]: %@", [data objectForKey:@"level"], [data objectForKey:@"message"]];
        NSLog(@"%@", message);
        [MobileNode log:message];
    }];
}

@end
