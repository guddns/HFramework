//
//  NSNumber+Additions.m
//  HFramework
//
//  Created by hug on 13. 10. 16..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "NSNumber+Additions.h"

@implementation NSNumber (Additions)

- (NSString *)toCommaString
{
    NSNumberFormatter *frmtr = [[NSNumberFormatter alloc] init];
    [frmtr setGroupingSize:3];
    [frmtr setGroupingSeparator:@","];
    [frmtr setUsesGroupingSeparator:YES];
    
    NSInteger number = [self integerValue];
    return [frmtr stringFromNumber:[NSNumber numberWithInt:number]];
}


@end
