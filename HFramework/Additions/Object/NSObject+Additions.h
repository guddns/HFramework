//
//  NSObject+Additions.h
//  HFramework
//
//  Created by 김형운 on 13. 7. 23..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Additions)

- (void)setURLEncodedValuesForKeysWithDictionary:(NSDictionary *)dic;

- (NSString *) descriptionForObject:(NSObject *)obj
							 locale:(id)locale
							 indent:(NSUInteger)level;

@end
