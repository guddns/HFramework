//
//  UIImage+Additions.m
//  HFramework
//
//  Created by hug on 13. 8. 1..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "UIImage+Additions.h"
#import <Foundation/Foundation.h>
#import <objc/objc-runtime.h>

static Method origImageNamedMethod = nil;

@implementation UIImage (Additions)

+ (void)load {
    if  ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) &&
		 ([UIScreen mainScreen].bounds.size.height > 480.0f)) {
        
        //Exchange XIB loading implementation
        Method m1 = class_getInstanceMethod(NSClassFromString(@"UIImageNibPlaceholder"), @selector(initWithCoder:));
    	Method m2 = class_getInstanceMethod(self, @selector(initWithCoderH568:));
		method_exchangeImplementations(m1, m2);
        
        //Exchange imageNamed: implementation
        method_exchangeImplementations(class_getClassMethod(self, @selector(imageNamed:)),
                                       class_getClassMethod(self, @selector(imageNamedH568:)));
    }
}

+ (UIImage *)imageNamedH568:(NSString *)imageName
{
    return [UIImage imageNamedH568:[self renameImageNameForH568:imageName]];
}

- (id)initWithCoderH568:(NSCoder *)aDecoder {
	NSString *resourceName = [aDecoder decodeObjectForKey:@"UIResourceName"];
    NSString *resourceH568 = [UIImage renameImageNameForH568:resourceName];
    
    if ([resourceName isEqualToString:resourceH568]) {
        return [self initWithCoderH568:aDecoder];
    }
    else {
        return [UIImage imageNamedH568:resourceH568];
    }
}

+ (NSString *)renameImageNameForH568:(NSString *)imageName {
    NSMutableString *imageNameMutable = [imageName mutableCopy];
    
    NSRange extension = [imageName rangeOfString:@".png" options:NSBackwardsSearch | NSAnchoredSearch];
    if (extension.location != NSNotFound) {
        [imageNameMutable deleteCharactersInRange:extension];
    }
    
    NSRange retinaAtSymbol = [imageName rangeOfString:@"@2x"];
    if (retinaAtSymbol.location != NSNotFound) {
        [imageNameMutable insertString:@"-568h" atIndex:retinaAtSymbol.location];
    } else {
        [imageNameMutable appendString:@"-568h@2x"];
    }
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageNameMutable ofType:@"png"];
    if (imagePath) {
        [imageNameMutable replaceOccurrencesOfString:@"@2x" withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [imageNameMutable length])];
        return imageNameMutable;
    } else {
        return imageName;
    }
}

+ (void)initialize {
    origImageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    method_exchangeImplementations(origImageNamedMethod,
                                   class_getClassMethod(self, @selector(retina4ImageNamed:)));
}

+ (UIImage *)retina4ImageNamed:(NSString *)imageName
{
    NSLog(@"Loading image named => %@", imageName);
    NSMutableString *imageNameMutable = [imageName mutableCopy];
    NSRange retinaAtSymbol = [imageName rangeOfString:@"@"];
    if (retinaAtSymbol.location != NSNotFound) {
        [imageNameMutable insertString:@"-568h" atIndex:retinaAtSymbol.location];
    } else {
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
            NSRange dot = [imageName rangeOfString:@"."];
            if (dot.location != NSNotFound) {
                [imageNameMutable insertString:@"-568h@2x" atIndex:dot.location];
            } else {
                [imageNameMutable appendString:@"-568h@2x"];
            }
        }
    }
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageNameMutable ofType:@"png"];
    if (imagePath) {
        return [UIImage retina4ImageNamed:imageNameMutable];
    } else {
        return [UIImage retina4ImageNamed:imageName];
    }
    return nil;
}

@end
