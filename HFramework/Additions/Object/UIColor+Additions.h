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
#define HEX_RGB(V)		[UIColor fromShortHexValue:V]
#undef	HEX_RGBA
#define HEX_RGBA(V,A)	[UIColor fromShortHexValue:V alpha:A]

#undef	COLOR_RGB
#define	COLOR_RGB(R,G,B)	[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]
#undef	COLOR_RGBA
#define COLOR_RGBA(R,G,B,A)	[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#undef	COLOR_HEX
#define COLOR_HEX(V)		[UIColor colorFromHexString:V]
#undef	COLOR_HEXA
#define COLOR_HEXA(V,A)		[UIColor colorFromHexString:V alpha:A]


////////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIColor (Additions)

+ (UIColor *)fromHexValue:(NSUInteger)hex;

+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)fromShortHexValue:(NSUInteger)hex;

+ (UIColor *)fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

/**
 @brief 헥사코드를 UIColor로 변경하는 매크로 3, 6자리 값을 모두 처리한다.
 @param alpha의 최소값은 0이고 최대값은 1이다.
 @author Hyeong Un Kim
 */
+ (UIColor *) colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 @brief 헥사코드를 UIColor로 변경하는 매크로 3, 6자리 값을 모두 처리한다.
 @author Hyeong Un Kim
 */
+ (UIColor *) colorFromHexString:(NSString *)hexString;

@end
