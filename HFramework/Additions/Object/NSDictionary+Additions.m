//
//  NSDictionary+Additions.m
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "NSDictionary+Additions.h"
#import "NSString+Additions.h"

@implementation NSDictionary (Additions)

- (NSObject *)objectAtPath:(NSString *)path
{
	return [self objectAtPath:path separator:nil];
}

- (NSObject *)objectAtPath:(NSString *)path separator:(NSString *)separator
{
	if ( nil == separator )	{
		path = [path stringByReplacingOccurrencesOfString:@"." withString:@"/"];
		separator = @"/";
	}
	
#if 1
	
	NSArray * array = [path componentsSeparatedByString:separator];
	if ( 0 == [array count] ) {
		return nil;
	}
    
	NSObject * result = nil;
	NSDictionary * dict = self;
	
	for ( NSString * subPath in array ) {
		if ( 0 == [subPath length] )
			continue;
		
		result = [dict objectForKey:subPath];
		if ( nil == result )
			return nil;
        
		if ( [array lastObject] == subPath ) {
			return result;
		} else if ( NO == [result isKindOfClass:[NSDictionary class]] ) {
			return nil;
		}
        
		dict = (NSDictionary *)result;
	}
	
	return (result == [NSNull null]) ? nil : result;
    
#else
	
	NSString *	keyPath = [path stringByReplacingOccurrencesOfString:separator withString:@"."];
	NSRange		range = NSMakeRange( 0, 1 );
    
	if ( [[keyPath substringWithRange:range] isEqualToString:@"."] )
	{
		keyPath = [keyPath substringFromIndex:1];
	}
    
	NSObject * result = [self valueForKeyPath:keyPath];
	return (result == [NSNull null]) ? nil : result;
	
#endif
}

- (BOOL)boolAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	if ( [obj isKindOfClass:[NSNull class]] )
	{
		return NO;
	}
	else if ( [obj isKindOfClass:[NSNumber class]] )
	{
		return [(NSNumber *)obj intValue] ? YES : NO;
	}
	else if ( [obj isKindOfClass:[NSString class]] )
	{
		if ( [(NSString *)obj hasPrefix:@"y"] ||
			[(NSString *)obj hasPrefix:@"Y"] ||
			[(NSString *)obj hasPrefix:@"T"] ||
			[(NSString *)obj hasPrefix:@"t"] ||
			[(NSString *)obj isEqualToString:@"1"] )
		{
			return YES;
		}
		else
		{
			return NO;
		}
	}
    
	return NO;
}

- (NSNumber *)numberAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	if ( [obj isKindOfClass:[NSNull class]] )
	{
		return nil;
	}
	else if ( [obj isKindOfClass:[NSNumber class]] )
	{
		return (NSNumber *)obj;
	}
	else if ( [obj isKindOfClass:[NSString class]] )
	{
		return [NSNumber numberWithDouble:[(NSString *)obj doubleValue]];
	}
    
	return nil;
}

- (NSString *)stringAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	if ( [obj isKindOfClass:[NSNull class]] )
	{
		return nil;
	}
	else if ( [obj isKindOfClass:[NSNumber class]] )
	{
		return [NSString stringWithFormat:@"%d", [(NSNumber *)obj intValue]];
	}
	else if ( [obj isKindOfClass:[NSString class]] )
	{
		return [(NSString *)obj urlDecodedString];
	}
	
	return nil;
}

- (NSArray *)arrayAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSArray class]] ? (NSArray *)obj : nil;
}

- (NSMutableArray *)mutableArrayAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSMutableArray class]] ? (NSMutableArray *)obj : nil;
}

- (NSDictionary *)dictAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSDictionary class]] ? (NSDictionary *)obj : nil;
}

- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSMutableDictionary class]] ? (NSMutableDictionary *)obj : nil;
}

@end
