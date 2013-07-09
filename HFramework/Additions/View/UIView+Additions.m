//
//  UIView+Additions.m
//  HFramework
//
//  Created by hug on 13. 6. 14..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "UIView+Additions.h"

#include <objc/runtime.h>

@implementation UIView (Additions)
@dynamic tagString;

- (CGPoint)origin {
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
	CGRect newFrame = self.frame;
	newFrame.origin = origin;
	self.frame = newFrame;
}

- (CGSize)size {
	return self.frame.size;
}

- (void)setSize:(CGSize)size {
	CGRect newFrame = self.frame;
	newFrame.size = size;
	self.frame = newFrame;
}

- (CGFloat)top {
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
	CGRect newFrame = self.frame;
	newFrame.origin.y = top;
	self.frame = newFrame;
}

- (CGFloat)left {
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
	CGRect newFrame = self.frame;
	newFrame.origin.x = left;
	self.frame = newFrame;
}

- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
	CGRect newFrame = self.frame;
	newFrame.origin.y = bottom - self.frame.size.height;
	self.frame = newFrame;
}

- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
	self.frame = frame;
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	CGRect newFrame = self.frame;
	newFrame.size.width = width;
	self.frame = newFrame;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	CGRect newFrame = self.frame;
	newFrame.size.height = height;
	self.frame = newFrame;
}

- (CGPoint)topRight {
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y;
	return CGPointMake(x, y);
}

- (CGPoint)topLeft {
    return self.origin;
}

- (void)setTopLeft:(CGPoint)topLeft {
    self.origin = topLeft;
}

- (void)setTopRight:(CGPoint)topRight {
	self.top = topRight.y;
	self.right = topRight.x;
}

- (CGPoint)bottomLeft {
	CGFloat x = self.frame.origin.x;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (void)setBottomLeft:(CGPoint)bottomLeft {
	self.bottom = bottomLeft.y;
	self.left = bottomLeft.x;
}

- (CGPoint)bottomRight {
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (void)setBottomRight:(CGPoint)bottomRight {
	self.bottom = bottomRight.y;
	self.right = bottomRight.x;
}

- (id)initWithNibName:(NSString *)nibNameOrNil {
    self = [super init];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil owner:self options:nil];
        self = [nibs objectAtIndex:0];
    }
    return self;
}

- (NSString *)tagString
{
	NSObject * obj = objc_getAssociatedObject( self, "UIView.tagString" );
	if ( obj && [obj isKindOfClass:[NSString class]] )
		return (NSString *)obj;
	
	return nil;
}

- (void)setTagString:(NSString *)value
{
	objc_setAssociatedObject( self, "UIView.tagString", value, OBJC_ASSOCIATION_RETAIN );
}

- (UIView *)viewWithTagString:(NSString *)value
{
	if ( nil == value )
		return nil;
	
	for ( UIView * subview in self.subviews ) {
		NSString * tag = subview.tagString;
		if ( [tag isEqualToString:value] ) {
			return subview;
		}
	}
	
	return nil;
}

- (UIView *)viewWithTagPath:(NSString *)path
{
	NSArray * array = [path componentsSeparatedByString:@"."];
	if ( 0 == [array count] ) {
		return nil;
	}
    
	UIView * result = self;
    
	for ( NSString * subPath in array ) {
		if ( 0 == subPath.length )
			continue;
        
		result = [result viewWithTagString:subPath];
		if ( nil == result )
			return nil;
        
		if ( [array lastObject] == subPath ) {
			return result;
		} else if ( NO == [result isKindOfClass:[UIView class]] ) {
			return nil;
		}
	}
    
	return result;
}

- (UIView *)viewAtPath:(NSString *)path
{
	if ( nil == path || 0 == path.length )
		return nil;
	
	NSString *	keyPath = [path stringByReplacingOccurrencesOfString:@"/" withString:@"."];
	NSRange		range = NSMakeRange( 0, 1 );
	
	if ( [[keyPath substringWithRange:range] isEqualToString:@"."] ) {
		keyPath = [keyPath substringFromIndex:1];
	}
	
	NSObject * result = [self valueForKeyPath:keyPath];
	if ( result == [NSNull null] || NO == [result isKindOfClass:[UIView class]] )
		return nil;
	
	return (UIView *)result;
}

- (UIView *)subview:(NSString *)name
{
	if ( nil == name || 0 == [name length] )
		return nil;
	
	NSObject * view = [self valueForKey:name];
	
	if ( [view isKindOfClass:[UIView class]] ) {
		return (UIView *)view;
	} else {
		return nil;
	}
}

- (UIView *)prevSibling
{
	if ( nil == self.superview )
		return nil;
	
	if ( self.superview.subviews.count <= 1 )
		return nil;
	
	NSUInteger count = self.superview.subviews.count;
	NSUInteger index = [self.superview.subviews indexOfObject:self];
	if ( 0 == index ) {
		index = count - 1;
	} else {
		index = index - 1;
	}
    
	return [self.superview.subviews objectAtIndex:index];
}

- (UIView *)nextSibling
{
	if ( nil == self.superview )
		return nil;
    
	if ( self.superview.subviews.count <= 1 )
		return nil;
    
	NSUInteger count = self.superview.subviews.count;
	NSUInteger index = [self.superview.subviews indexOfObject:self];
    
	return [self.superview.subviews objectAtIndex:(index + 1) % count];
}

- (void)removeAllSubviews
{
	for ( UIView * view in self.subviews) {
		[view removeFromSuperview];
	}
}

- (UIViewController *)viewController
{
	if ( nil == self.superview )
		return nil;
	
	id nextResponder = [self nextResponder];
	if ( [nextResponder isKindOfClass:[UIViewController class]] ) {
		return (UIViewController *)nextResponder;
	} else {
		return [nextResponder viewController];
	}
}

- (void)hideKeyboardForStatement:(UIView *)view
{
	for (int i = 0; i < [view.subviews count]; i++) {
		UIView *tempView = [view.subviews objectAtIndex:i];
		NSInteger subViewCount = [[tempView subviews] count];
		if (subViewCount > 0) {
			[self hideKeyboardForStatement:tempView];
		} else {
			if ([tempView conformsToProtocol:@protocol(UITextInputTraits)]) {
				[tempView resignFirstResponder];
			}
		}
	}
}

- (void)hideKeyboard
{
	UIWindow *window;
	for (int i = 0; i < [[[UIApplication sharedApplication] windows] count]; i++) {
		window = [[[UIApplication sharedApplication] windows] objectAtIndex:i];
		for (int j = 0; j < [window.subviews count]; j++) {
			[self hideKeyboardForStatement:[window.subviews objectAtIndex:j]];
		}
	}
}

@end
