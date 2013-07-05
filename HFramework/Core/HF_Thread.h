//
//  Hu_Thread.h
//
//  Created by hug on 13. 5. 23..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HF_Singleton.h"

#pragma mark -

#define FOREGROUND_BEGIN	[[HuTaskQueue sharedInstance] enqueueForeground:^{
#define FOREGROUND_DELAY(x)	[[HuTaskQueue sharedInstance] enqueueForegroundWithDelay:(dispatch_time_t)x block:^{
#define FOREGROUND_COMMIT	}];

#define BACKGROUND_BEGIN	[[HuTaskQueue sharedInstance] enqueueBackground:^{
#define BACKGROUND_DELAY(x)	[[HuTaskQueue sharedInstance] enqueueBackgroundWithDelay:(dispatch_time_t)x block:^{
#define BACKGROUND_COMMIT	}];

#pragma mark -

@interface HFTaskQueue : NSObject
{
    dispatch_queue_t _foreQueue;
    dispatch_queue_t _backQueue;
}

AS_SINGLETON(HFTaskQueue);

- (dispatch_queue_t)foreQueue;
- (dispatch_queue_t)backQueue;

- (void)enqueueForeground:(dispatch_block_t)block;
- (void)enqueueBackground:(dispatch_block_t)block;
- (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;
- (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;

@end
