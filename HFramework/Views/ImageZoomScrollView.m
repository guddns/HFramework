//
//  ImageZoomScrollView.m
//  HFramework
//
//  Created by hug on 2014. 2. 6..
//  Copyright (c) 2014년 hug. All rights reserved.
//

#import "ImageZoomScrollView.h"

@implementation ImageZoomScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.delegate = self;
		[self initialize];
    }
    return self;
}

- (void)initialize
{
	_imageView = [[UIImageView alloc] init];
	[self addSubview:_imageView];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGSize boundsSize = self.bounds.size;
	CGRect imageFrame = CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height);
	
	if (imageFrame.size.width < boundsSize.width) {
		imageFrame.origin.x = (boundsSize.width - imageFrame.size.width) / 2;
	}
	
	if (imageFrame.size.height < boundsSize.height) {
		imageFrame.origin.y = (boundsSize.height - imageFrame.size.height) / 2;
	}
	
	_imageView.frame = imageFrame;
}


#pragma mark - setter, getter

- (void)setImage:(UIImage *)image
{
	_image = image;
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		CGSize imageSize = image.size;
		CGSize maxSize = self.frame.size;
		CGFloat widthRatio = maxSize.width / imageSize.width;
		CGFloat heightRatio = maxSize.height / imageSize.height;
		CGFloat initialZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
		
		self.contentSize = imageSize;
		self.minimumZoomScale = initialZoom;
		self.zoomScale = initialZoom;
		
		dispatch_async(dispatch_get_main_queue(), ^{
			_imageView.image = image;
			[_imageView sizeToFit];
		});
	});
}


#pragma mark - UIScrollView delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return _imageView;
}

@end
