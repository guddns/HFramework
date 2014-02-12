//
//  UIButton+Additions.h
//  HFramework
//
//  Created by hug on 13. 7. 9..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Additions)

+ (UIButton *)buttonWithImageNamed:(NSString *)name;

+ (UIButton *)buttonWithImage:(UIImage *)dImg delegate:(id)delegate action:(SEL)action;

+ (UIButton *)buttonWithImage:(UIImage *)dImg highlightImage:(UIImage *)hImg delegate:(id)delegate action:(SEL)action;

- (void)addEventHandler:(void (^)(void))handler forControlEvents:(UIControlEvents)controlEvents;

@end
