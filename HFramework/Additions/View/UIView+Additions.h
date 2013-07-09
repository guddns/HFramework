//
//  UIView+Additions.h
//  HFramework
//
//  Created by hug on 13. 6. 14..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

@property (nonatomic, strong) NSString *tagString;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint topLeft;
@property (nonatomic, assign) CGPoint topRight;
@property (nonatomic, assign) CGPoint bottomLeft;
@property (nonatomic, assign) CGPoint bottomRight;

- (id)initWithNibName:(NSString *)nibNameOrNil;

- (UIView *)viewWithTagString:(NSString *)value;

- (UIView *)viewWithTagPath:(NSString *)value;

- (UIView *)viewAtPath:(NSString *)name;

- (UIView *)subview:(NSString *)name;

- (UIView *)prevSibling;

- (UIView *)nextSibling;

- (void)removeAllSubviews;

- (UIViewController *)viewController;

- (void)hideKeyboardForStatement:(UIView *)view;

- (void)hideKeyboard;

@end
