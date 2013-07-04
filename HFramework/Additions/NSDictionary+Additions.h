//
//  NSDictionary+Additions.h
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

- (NSObject *)objectAtPath:(NSString *)path;

- (NSObject *)objectAtPath:(NSString *)path separator:(NSString *)separator;

- (BOOL)boolAtPath:(NSString *)path;

- (NSNumber *)numberAtPath:(NSString *)path;

- (NSString *)stringAtPath:(NSString *)path;

- (NSArray *)arrayAtPath:(NSString *)path;

- (NSMutableArray *)mutableArrayAtPath:(NSString *)path;

- (NSDictionary *)dictAtPath:(NSString *)path;

- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path;

@end
