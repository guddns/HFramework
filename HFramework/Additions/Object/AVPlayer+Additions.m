//
//  AVPlayer+Additions.m
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "AVPlayer+Additions.h"

@implementation AVPlayer (Additions)

- (BOOL)isPlaying
{
    return self.rate != 0.0f;
}

- (Float64)currentTimeSeconds
{
    return CMTimeGetSeconds([self currentTime]);
}

- (CMTime)durationTime
{
    AVPlayerItem *playerItem = [self currentItem];
    if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
        return [playerItem duration];
    }
    
    return kCMTimeInvalid;
}

- (Float64)durationTimeSeconds
{
    return CMTimeGetSeconds([self durationTime]);
}

- (Float64)bufferTimeSeconds
{
    AVPlayerItem *item = self.currentItem;
    if (item.status == AVPlayerItemStatusReadyToPlay) {
        NSArray *timeRangeArray = item.loadedTimeRanges;
        CMTimeRange aTimeRange = [[timeRangeArray objectAtIndex:0] CMTimeRangeValue];
        double startTime = CMTimeGetSeconds(aTimeRange.start);
        double loadedDuration = CMTimeGetSeconds(aTimeRange.duration);
        
        return (NSTimeInterval)(startTime + loadedDuration);
    }
    
    return (CMTimeGetSeconds(kCMTimeInvalid));
}

@end
