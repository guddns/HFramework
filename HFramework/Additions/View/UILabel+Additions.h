//
//  UILabel+Additions.h
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Additions)

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth;

- (CGSize)sizeWithMaxHeight:(CGFloat)maxHeight;

- (CGFloat)heightForWidth:(CGFloat)width;

- (CGFloat)widthForHeight:(CGFloat)height;

- (void) adjustedToFitTheSizeOfTheWidth;

@end
