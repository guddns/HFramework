//
//  UIButton+Additions.m
//  HFramework
//
//  Created by hug on 13. 7. 9..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "UIButton+Additions.h"

@implementation UIButton (Additions)

+ (UIButton *)buttonWithImageNamed:(NSString *)name
{
	UIButton *btn = [[UIButton alloc] init];
	[btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
	[btn sizeToFit];
	return btn;
}

+ (UIButton *)createWithImage:(UIImage *)nImg delegate:(id)delegate action:(SEL)action
{
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, nImg.size.width, nImg.size.height)];
	[button setImage:nImg forState:UIControlStateNormal];
	[button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
	return button;
}

+ (UIButton *)createWithImage:(UIImage *)nImg highlightImage:(UIImage *)hImg delegate:(id)delegate action:(SEL)action
{
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, nImg.size.width, nImg.size.height)];
	[button setImage:nImg forState:UIControlStateNormal];
	[button setImage:hImg forState:UIControlStateHighlighted];
	[button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
	return button;
}

@end
