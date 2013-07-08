//
//  NSString+Additions.h
//  HFramework
//
//  Created by 김형운 on 13. 7. 9..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (BOOL)isEmail;

- (NSString *)toCommaString;

- (NSString *)urlEncodedString;

- (NSString *)urlDecodedString;

@end
