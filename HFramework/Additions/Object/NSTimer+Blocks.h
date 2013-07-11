//
//  NSTimer+Blocks.h
//  HFramework
//
//  Created by hug on 13. 7. 11..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Blocks)

+ (NSTimer *) scheduledTimerWithTimeInterval: (NSTimeInterval) seconds
							 		 repeats: (BOOL) repeats
							  		   block: (void (^) (NSTimer * timer)) block;

+ (NSTimer *) timerWithTimeInterval: (NSTimeInterval) seconds
						    repeats: (BOOL) repeats
							  block: (void (^) (NSTimer * timer)) block;

@end
