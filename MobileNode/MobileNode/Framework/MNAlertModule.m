//
//  MNAlertModule.m
//  MobileNodeGame
//
//  Created by Kevin Whinnery on 10/13/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNAlertModule.h"
#import "MobileNode.h"

@implementation MNAlertModule

+(void)init
{
    [MobileNode defineFunction:@"alert" withBlock:(id)^(NSDictionary* data) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[data objectForKey:@"title"]
                                                        message:[data objectForKey:@"message"]
                                                       delegate:nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }];
}

@end
