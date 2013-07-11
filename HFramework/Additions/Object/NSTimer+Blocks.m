//
//  NSTimer+Blocks.m
//  HFramework
//
//  Created by hug on 13. 7. 11..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "NSTimer+Blocks.h"

typedef void (^ TimerBlock) (NSTimer *);

@interface NSTimer (NSTimer_blocks_private)

+ (void)BlockTimer_executeBlockWithTimer: (NSTimer *) timer;

@end

@implementation NSTimer (Blocks)

+ (NSTimer *) scheduledTimerWithTimeInterval: (NSTimeInterval) seconds
									 repeats: (BOOL) repeats
									   block: (void (^) (NSTimer * timer)) block {
    return [self scheduledTimerWithTimeInterval: seconds
										 target: self
									   selector: @selector(BlockTimer_executeBlockWithTimer:)
									   userInfo: [block copy]
										repeats: repeats];
}

+ (NSTimer *) timerWithTimeInterval: (NSTimeInterval) seconds
							repeats: (BOOL) repeats
							  block: (void (^) (NSTimer * timer)) block {
    return [self timerWithTimeInterval: seconds
								target: self
							  selector: @selector(BlockTimer_executeBlockWithTimer:)
							  userInfo: [block copy] 
							   repeats: repeats];
}

@end

@implementation NSTimer (NSTimer_blocks_private)

+ (void) BlockTimer_executeBlockWithTimer: (NSTimer *) timer {
    if([timer isValid]) {
        TimerBlock block = [timer userInfo];
        block(timer);
    }
}

@end