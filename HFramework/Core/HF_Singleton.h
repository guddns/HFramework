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


////////////////////////////////////////////////////////////////////////
// 클래스를 싱글톤으로 생성하는 매크로

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\
- (id)retain \
{ \
return self; \
} \
\
- (NSUInteger)retainCount \
{ \
return NSUIntegerMax; \
} \
\
- (id)autorelease \
{ \
return self; \
}

////////////////////////////////////////////////////////////////////////
// XIB 가 있는 ViewController 의 getter 를 추가하는 매크로

#define NEW_INSTANTIATION_XIB(type) \
\
- (type *)create##type { \
type *vc = [[[type alloc] initWithNibName:[NSString stringWithFormat:@"%@", [type class]] bundle:nil] autorelease]; \
NSLog(@"%@ is instantiation.", vc); \
return vc; \
}


////////////////////////////////////////////////////////////////////////
// XIB 가 있는 ViewController 의 getter 를 추가하는 매크로

#define LAZY_INSTANTIATION_XIB(type, name) \
\
- (type *)name { \
if (_##name == nil) { \
_##name = [[type alloc] initWithNibName:[NSString stringWithFormat:@"%@", [type class]] bundle:nil]; \
NSLog(@"%@ is instantiation.", _##name); \
} \
return _##name; \
}


////////////////////////////////////////////////////////////////////////
// getter 를 추가하는 매크로

#define LAZY_INSTANTIATION(type, name) \
\
- (type *)name { \
if (!_##name) { \
_##name = [[type alloc] init]; \
NSLog(@"%@ is instantiation.", _##name); \
} \
return _##name; \
}