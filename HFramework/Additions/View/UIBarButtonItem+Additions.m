//
//  UIBarButtonItem+Additions.m
//  HFramework
//
//  Created by hug on 13. 7. 9..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "UIBarButtonItem+Additions.h"
#import "HF_Precompile.h"
#import "UIView+Additions.h"
#import "UIButton+Additions.h"

@implementation UIBarButtonItem (Additions)

+ (UIBarButtonItem *)createWithImage:(UIImage *)nImg delegate:(id)delegate action:(SEL)action
{
	UIButton *button = [UIButton createWithImage:nImg delegate:delegate action:action];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	return barButtonItem;
}

+ (UIBarButtonItem *)createWithImage:(UIImage *)nImg highlightImage:(UIImage *)hImg delegate:(id)delegate action:(SEL)action
{
	UIButton *button = [UIButton createWithImage:nImg highlightImage:hImg delegate:delegate action:action];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	return barButtonItem;
}

@end
