//
//  AVPlayer+Additions.h
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AVPlayer (Additions)

- (BOOL)isPlaying;

- (Float64)currentTimeSeconds;

- (CMTime)durationTime;

- (Float64)durationTimeSeconds;

- (Float64)bufferTimeSeconds;

@end
