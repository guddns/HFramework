//
//  CGRect+Additions.h
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

UIInterfaceOrientation HFInterfaceOrientation();

CGAffineTransform HFRotateTransformForOrientation(UIInterfaceOrientation orientation);

CGRect HFScreenBounds();

CGRect HFApplicationFrame();