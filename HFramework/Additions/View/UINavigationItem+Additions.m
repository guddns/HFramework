//
//  UINavigationItem+Additions.m
//  HFramework
//
//  Created by hug on 2014. 2. 12..
//  Copyright (c) 2014년 hug. All rights reserved.
//

#import "UINavigationItem+Additions.h"

@implementation UINavigationItem (Additions)

//- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
//{
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width = -10;
//        [self setLeftBarButtonItems:@[negativeSpacer, leftBarButtonItem]];
//    } else {
//        // Just set the UIBarButtonItem as you would normally
//        [self setLeftBarButtonItem:leftBarButtonItem];
//    }
//}
//
//- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
//{
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        // Add a negative spacer on iOS >= 7.0
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//										   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//										   target:nil action:nil];
//        negativeSpacer.width = -10;
//        [self setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem, nil]];
//    } else {
//        // Just set the UIBarButtonItem as you would normally
//        [self setRightBarButtonItem:rightBarButtonItem];
//    }
//}

@end
