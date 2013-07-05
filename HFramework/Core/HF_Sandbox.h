//
//  Hu_Sandbox.h
//  itube
//
//  Created by hug on 13. 5. 23..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HF_Precompile.h"

@interface HFSandbox : NSObject

+ (NSString *)appPath;

+ (NSString *)docPath;

+ (NSString *)libPrefPath;

+ (NSString *)libCachePath;

+ (NSString *)tmpPath;

+ (BOOL)touch:(NSString *)path;

@end
