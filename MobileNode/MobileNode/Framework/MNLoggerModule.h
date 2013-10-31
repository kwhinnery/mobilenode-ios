//
//  MNLoggerModule.h
//  MobileNodeGame
//
//  Created by Kevin Whinnery on 10/13/13.
//  Copyright (c) 2013 Kevin Whinnery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNLoggerModule : NSObject
// Initialize and subscribe for JS event
+(void)init;

// Log a message to both JS and NSlog
+(void)log:(NSString*)msg level:(NSString*)levelOrNil;

@end
