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

- (NSString *) descriptionForObject:(NSObject *)obj
                            locale:(id)locale
                            indent:(NSUInteger)level
{
//    NSString *objString = nil;
//	
//    if ([obj isKindOfClass:[NSString class]]) {
//        objString = [NSString stringWithFormat:@"\"%@\"", (NSString *)obj];
//    }
//    else if ([obj respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
//		
//        objString = [obj performSelector:@selector(descriptionWithLocale:indent:)
//                              withObject:locale
//                              withObject:[NSNumber numberWithInteger:level]];
//    }
//    else if ([obj respondsToSelector:@selector(descriptionWithLocale:)]) {
//        objString = [obj performSelector:@selector(descriptionWithLocale:)
//                              withObject:locale];
//    }
//    else {
//        objString = [obj description];
//    }
//	
//    return objString;
	
	NSString *objString = nil;
	
    if ([obj isKindOfClass:[NSString class]]) {
        objString = [NSString stringWithFormat:@"\"%@\"", (NSString *)obj];
    }
	else if ([obj isKindOfClass:[NSArray class]]) {
		objString = [(NSArray *)obj descriptionWithLocale:locale indent:level];
    }
	else if ([obj isKindOfClass:[NSDictionary class]]) {
		objString = [(NSDictionary *)obj descriptionWithLocale:locale indent:level];
    }
    else if ([obj respondsToSelector:@selector(descriptionWithLocale:)]) {
        objString = [obj performSelector:@selector(descriptionWithLocale:) withObject:locale];
    }
    else {
        objString = [obj description];
    }
	
    return objString;

}

@end
