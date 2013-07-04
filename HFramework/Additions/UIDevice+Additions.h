//
//  UIDevice+Additions.h
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Additions)

- (NSString *)macAddressForInterface:(NSString *)interface;

- (NSString *)uniqueApplicationDeviceIdentifier;

- (NSString *)uniqueGlobalDeviceIdentifier;

@end
