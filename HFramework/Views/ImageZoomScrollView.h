//
//  ImageZoomScrollView.h
//  HFramework
//
//  Created by hug on 2014. 2. 6..
//  Copyright (c) 2014년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageZoomScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end
