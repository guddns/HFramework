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

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)dImg delegate:(id)delegate action:(SEL)action
{
	UIButton *button = [UIButton buttonWithImage:dImg delegate:delegate action:action];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)dImg highlightImage:(UIImage *)hImg delegate:(id)delegate action:(SEL)action
{
	UIButton *button = [UIButton buttonWithImage:dImg highlightImage:hImg delegate:delegate action:action];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemSpace:(NSInteger)width
{
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	buttonItem.width = width;
	return buttonItem;
}

@end
