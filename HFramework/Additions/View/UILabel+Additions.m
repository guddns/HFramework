//
//  UILabel+Additions.m
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "UILabel+Additions.h"

@implementation UILabel (Additions)

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth {
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX) lineBreakMode:self.lineBreakMode];
    return CGSizeMake(MIN(maxWidth, size.width), size.height);
}

- (CGSize)sizeWithMaxHeight:(CGFloat)maxHeight {
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, maxHeight) lineBreakMode:self.lineBreakMode];
    return CGSizeMake(size.width, MIN(maxHeight, size.height));
}

- (CGFloat)heightForWidth:(CGFloat)width {
    return [self sizeWithMaxWidth:width].height;
}

- (CGFloat)widthForHeight:(CGFloat)height {
    return [self sizeWithMaxHeight:height].width;
}

@end
