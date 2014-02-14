//
//  UIBarButtonItem+Additions.h
//  HFramework
//
//  Created by hug on 13. 7. 9..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Additions)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)dImg delegate:(id)delegate action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)dImg highlightImage:(UIImage *)hImg delegate:(id)delegate action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemSpace:(NSInteger)width;

@end
