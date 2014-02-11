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

- (void)adjustedToFitTheSizeOfTheWidth
{
	CGSize size = [self.text sizeWithFont:self.font];
	CGRect rect = self.frame;
	rect.size.width = size.width;
	self.frame = rect;
}

- (CGSize)sizeToFitWidth
{
	CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:self.lineBreakMode];
	CGRect frame = self.frame;
	frame.size.height = size.height;
	self.frame = frame;
	return self.frame.size;
}

- (CGSize)sizeToFitHeight
{
	CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height) lineBreakMode:self.lineBreakMode];
	CGRect frame = self.frame;
	frame.size.width = size.width;
	self.frame = frame;
	return self.frame.size;
}

@end
