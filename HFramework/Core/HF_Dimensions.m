//
//  CGRect+Additions.m
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HF_Dimensions.h"

UIInterfaceOrientation HFInterfaceOrientation() {
	return [[UIApplication sharedApplication] statusBarOrientation];
}

CGAffineTransform HFRotateTransformForOrientation(UIInterfaceOrientation orientation) {
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

CGRect HFScreenBounds() {
	return [[UIScreen mainScreen] bounds];
}

CGRect HFApplicationFrame() {
	return [[UIScreen mainScreen] applicationFrame];
}