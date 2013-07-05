//
//  HF_Log.h
//  HFramework
//
//  Created by hug on 13. 7. 5..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HF_Precompile.h"

// DEBUG
#ifdef DEBUG
	//#define NSLog(s, ...) NSLog(@"[%@ %s(%d)] %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
	#define NSLog(s, ...) NSLog(@"%s(%d) %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
	#define NSLog(s, ...)
#endif