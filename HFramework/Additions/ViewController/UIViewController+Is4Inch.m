//
//  UIViewController+Is4Inch.m
//  HFramework
//
//  Created by hug on 13. 8. 6..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "UIViewController+Is4Inch.h"
#import <objc/runtime.h>

#define IS_4_INCH CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(568, 320))

@implementation UIViewController (Is4Inch)

- (id)initWith4InchNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *newNibNameOrNil = nil;
	
    if (IS_4_INCH) newNibNameOrNil = [nibNameOrNil stringByAppendingString:@"_iPhone5"];
    
    if ([[NSBundle mainBundle] pathForResource:newNibNameOrNil ofType:@"nib"]) {
        return [self performSelector:@selector(initWithLegacyNibName:bundle:) withObject:newNibNameOrNil withObject:nibBundleOrNil];
    }
    if ([[NSBundle mainBundle] pathForResource:nibNameOrNil ofType:@"nib"])
    {
        return [self performSelector:@selector(initWithLegacyNibName:bundle:) withObject:nibNameOrNil    withObject:nibBundleOrNil];
    }
    
    [NSException raise:NSInternalInconsistencyException format:@"Could not load NIB in bundle:%@ with name '%@'", [NSBundle mainBundle], newNibNameOrNil];
    return nil;
}

+ (void)load
{
    class_addMethod([self class], @selector(initWithLegacyNibName:bundle:), [self instanceMethodForSelector:@selector(initWithNibName:bundle:)], "v@:@@");
    
    Method new = class_getInstanceMethod(self, @selector(initWith4InchNibName:bundle:));
    class_replaceMethod([self class], @selector(initWithNibName:bundle:), method_getImplementation(new), "v@:@@");
}

@end
