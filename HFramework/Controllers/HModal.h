//
//  HModal.h
//  HFramework
//
//  Created by hug on 13. 8. 8..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KGModalBackgroundDisplayStyle){
    KGModalBackgroundDisplayStyleGradient,
    KGModalBackgroundDisplayStyleSolid
};

@interface HModal : NSObject

@property (nonatomic) BOOL tapOutsideToDismiss;
@property (nonatomic) BOOL animateWhenDismissed;
@property (nonatomic, strong) UIColor *modalBackgroundColor;
@property (nonatomic) KGModalBackgroundDisplayStyle backgroundDisplayStyle;
@property (nonatomic) BOOL shouldRotate;

+ (instancetype)sharedInstance;

- (void)showWithContentView:(UIView *)contentView;

- (void)showWithContentView:(UIView *)contentView andAnimated:(BOOL)animated;

- (void)showWithContentViewController:(UIViewController *)contentViewController;

- (void)showWithContentViewController:(UIViewController *)contentViewController andAnimated:(BOOL)animated;

- (void)hide;

- (void)hideWithCompletionBlock:(void(^)())completion;

- (void)hideAnimated:(BOOL)animated;

- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)())completion;

@end
