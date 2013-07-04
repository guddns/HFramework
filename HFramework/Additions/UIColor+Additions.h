//
//  UIColor+Additions.h
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef	RGB
#define	RGB(R,G,B)		[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]

#undef	RGBA
#define RGBA(R,G,B,A)	[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#undef	HEX_RGB
#define HEX_RGB(V)		[UIColor fromHexValue:V]

#undef	HEX_RGBA
#define HEX_RGBA(V,A)	[UIColor fromHexValue:V alpha:A]


////////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIColor (Additions)

+ (UIColor *)fromHexValue:(NSUInteger)hex;

+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)fromShortHexValue:(NSUInteger)hex;

+ (UIColor *)fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

@end
