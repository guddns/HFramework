//
//  NSArray+Additions.m
//  HFramework
//
//  Created by hug on 13. 9. 5..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "NSArray+Additions.h"
#import "NSObject+Additions.h"

@implementation NSArray (Additions)

- (NSString *) descriptionWithLocale:(id)locale
							  indent:(NSUInteger)level
{
	NSMutableString *log = [NSMutableString string];
	
	if ([self count] == 0) {
		[log appendString:@"There has no object."];
	} else {
		[log appendString:@"(\n"];
		
		NSMutableString *indentString = [NSMutableString string];
		for (int i = 0; i < level; i++) {
			[indentString appendString:@"\t"];
		}
		
		for (int i = 0; i < [self count]; i++) {
			[log appendFormat:@"\t%@%@", indentString,
			 [self descriptionForObject:self[i] locale:locale indent:level + 1]];
			
			if (i + 1 < [self count]) {
				[log appendString:@",\n"];
			} else {
				[log appendString:@"\n"];
			}
		}
		
		[log appendFormat:@"%@)", indentString];
	}
	
	return log;
}

@end
