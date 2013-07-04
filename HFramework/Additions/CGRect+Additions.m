//
//  CGRect+Additions.m
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "CGRect+Additions.h"

UIInterfaceOrientation HInterfaceOrientation() {
	return [[UIApplication sharedApplication] statusBarOrientation];
}

CGAffineTransform HRotateTransformForOrientation(UIInterfaceOrientation orientation) {
	if (orientation == UIInterfaceOrientationLandscapeLeft) {
		return CGAffineTransformMakeRotation(M_PI * 1.5);
	} else if (orientation == UIInterfaceOrientationLandscapeRight) {
		return CGAffineTransformMakeRotation(M_PI / 2);
	} else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
		return CGAffineTransformMakeRotation(-M_PI);
	} else {
		return CGAffineTransformIdentity;
	}
}

CGRect HScreenBounds() {
	return [[UIScreen mainScreen] bounds];
}

CGRect HApplicationFrame() {
	return [[UIScreen mainScreen] applicationFrame];
}