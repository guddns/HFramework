//
//  NSObject+Additions.m
//  HFramework
//
//  Created by 김형운 on 13. 7. 23..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "NSObject+Additions.h"
#import "NSString+Additions.h"

@implementation NSObject (Additions)

- (void)setURLEncodedValuesForKeysWithDictionary:(NSDictionary *)dic
{
	for (id aKey in dic) {
		id object  = [dic objectForKey:aKey];
		if ([object isKindOfClass:[NSString class]]) {
			[self setValue:[object urlDecodedString] forKey:aKey];
		} else {
			[self setValue:object forKey:aKey];
		}
	}
}

@end
