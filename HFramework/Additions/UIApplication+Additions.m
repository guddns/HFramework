//
//  UIApplication+Additions.m
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "UIApplication+Additions.h"

@implementation UIApplication (Additions)

- (CGFloat)statusBarWidth
{
	CGRect frame = [[UIApplication sharedApplication] statusBarFrame];
	
	switch ([[UIApplication sharedApplication] statusBarOrientation]) {
		case UIInterfaceOrientationPortrait: return frame.size.width;
		case UIInterfaceOrientationPortraitUpsideDown: return frame.size.width;
		case UIInterfaceOrientationLandscapeLeft: return frame.size.height;
		case UIInterfaceOrientationLandscapeRight: return frame.size.height;
	}
}

- (CGFloat)statusBarHeight
{
	CGRect frame = [[UIApplication sharedApplication] statusBarFrame];
	
	switch ([[UIApplication sharedApplication] statusBarOrientation]) {
		case UIInterfaceOrientationPortrait: return frame.size.height;
		case UIInterfaceOrientationPortraitUpsideDown: return frame.size.height;
		case UIInterfaceOrientationLandscapeLeft: return frame.size.width;
		case UIInterfaceOrientationLandscapeRight: return frame.size.width;
	}
}

- (CGRect)statusBarBounds
{
	return CGRectMake(0, 0, [self statusBarWidth], [self statusBarHeight]);
}

@end
