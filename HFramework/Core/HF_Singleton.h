//
//  Hu_Singleton.h
//
//  Created by hug on 13. 5. 23..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HF_Precompile.h"

#undef  AS_SINGLETON
#define AS_SINGLETON(__class) \
    + (__class *)sharedInstance;

#undef  DEF_SINGLETON
#define DEF_SINGLETON(__class) \
    + (__class *)sharedInstance \
    { \
        static dispatch_once_t once; \
        static __class *__singleton__; \
        dispatch_once(&once, ^{ \
            __singleton__ = [[__class alloc] init]; \
        }); \
        return __singleton__; \
    }