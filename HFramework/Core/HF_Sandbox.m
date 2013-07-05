//
//  Hu_Sandbox.m
//  itube
//
//  Created by hug on 13. 5. 23..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HF_Precompile.h"
#import "HF_Sandbox.h"

@implementation HFSandbox

+ (NSString *)appPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

+ (NSString *)docPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	return [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
}

+ (BOOL)touch:(NSString *)path {
	if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] ) {
		return [[NSFileManager defaultManager] createDirectoryAtPath:path
										 withIntermediateDirectories:YES
														  attributes:nil
															   error:NULL];
	}
	return NO;
}

@end
