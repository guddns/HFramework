//
//  UIButton+Additions.m
//  HFramework
//
//  Created by hug on 13. 7. 9..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "UIButton+Additions.h"
#import <objc/runtime.h>


@interface BlockActionWrapper : NSObject

@property (nonatomic, copy) void (^blockAction)(void);

- (void)invokeBlock:(id)sender;

@end

@implementation BlockActionWrapper

- (void)dealloc {
	[self setBlockAction:nil];
}

- (void)invokeBlock:(id)sender {
	[self blockAction]();
}

@end


////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIButton (Additions)

+ (UIButton *)buttonWithImageNamed:(NSString *)name
{
	UIButton *btn = [[UIButton alloc] init];
	[btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
	[btn sizeToFit];
	return btn;
}

+ (UIButton *)buttonWithImage:(UIImage *)dImg delegate:(id)delegate action:(SEL)action
{
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, dImg.size.width, dImg.size.height)];
	[button setImage:dImg forState:UIControlStateNormal];
	[button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
	return button;
}

+ (UIButton *)buttonWithImage:(UIImage *)dImg highlightImage:(UIImage *)hImg delegate:(id)delegate action:(SEL)action
{
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, dImg.size.width, dImg.size.height)];
	[button setImage:dImg forState:UIControlStateNormal];
	[button setImage:dImg forState:UIControlStateHighlighted];
	[button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
	return button;
}

static const char *UIControlBlockActions = "unique";

- (void)addEventHandler:(void (^)(void))handler forControlEvents:(UIControlEvents)controlEvents {
	NSMutableArray *blockActions = objc_getAssociatedObject(self, &UIControlBlockActions);
	if (blockActions == nil) {
		blockActions = [NSMutableArray array];
		objc_setAssociatedObject(self, &UIControlBlockActions, blockActions, OBJC_ASSOCIATION_RETAIN);
	}
	
	BlockActionWrapper *target = [[BlockActionWrapper alloc] init];
	[target setBlockAction:handler];
	[blockActions addObject:target];
	
	[self addTarget:target action:@selector(invokeBlock:) forControlEvents:controlEvents];
}

@end
