//
//  UIDevice+Additions.m
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "UIDevice+Additions.h"

#import <CommonCrypto/CommonDigest.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>

NSString* NSStringGenerateSHA1FromString(NSString *string);


////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIDevice (Additions)

- (NSString *)macAddressForInterface:(NSString *)interface
{
	//look up the interface number
    int interfaceIndex =  if_nametoindex([interface UTF8String]);
    if (interfaceIndex == 0){
        NSLog(@"Error: if_nametoindex failure.");
        return nil;
    }
    
    //create our mib (Management Information Base)
    int mib[] = {
        CTL_NET,        /* request network subsystem */
        AF_ROUTE,       /* routing table info */
        0,              /*  */
        AF_LINK,        /* request link layer info */
        NET_RT_IFLIST,  /* request all configured interfaces */
        interfaceIndex  /* include the interface we are interested in */
    };
    
    //look up the length of our expected result
    size_t length = 0;
    if (sysctl(mib, 6, NULL, &length, NULL, 0) < 0) {
        NSLog(@"Error: looking up length for interfaceMessageBuffer.");
        return nil;
    }
    
    //allocate memory for resultant structure
    char *interfaceBuffer = malloc(length);
    if (!interfaceBuffer){
        NSLog(@"Error: looking allocating memory for interfaceMessageBuffer.");
        return nil;
    }
    
    //get our result
    if (sysctl(mib, 6, interfaceBuffer, &length, NULL, 0) < 0) {
        NSLog(@"Error: sysctl failed to populate interfaceMessageBuffer.");
        free(interfaceBuffer);
        return nil;
    }
    
    //get the mac address from the resulting interfaceBuffer. It consists of 2 structs, a header followed by the llsocket struct
    struct if_msghdr *interfaceMessageHeaderStruct = (struct if_msghdr*)interfaceBuffer;
    struct sockaddr_dl *linkLevelSocketStruct = (struct sockaddr_dl *)(interfaceMessageHeaderStruct + 1); //comes after the message header
    unsigned char *macAddressPtr = (unsigned char *)LLADDR(linkLevelSocketStruct);
    NSString *macAddress = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *macAddressPtr, *(macAddressPtr+1), *(macAddressPtr+2), *(macAddressPtr+3), *(macAddressPtr+4), *(macAddressPtr+5)];
    free(interfaceBuffer);
    
    return macAddress;
}

- (NSString *)uniqueApplicationDeviceIdentifier
{
	return NSStringGenerateSHA1FromString([NSString stringWithFormat:@"RHDeviceIdentifier-%@-%@", [[NSBundle mainBundle] bundleIdentifier], [self macAddressForInterface:@"en0"]]);
}

- (NSString *)uniqueGlobalDeviceIdentifier
{
	return NSStringGenerateSHA1FromString([NSString stringWithFormat:@"RHDeviceIdentifier-%@",[self macAddressForInterface:@"en0"]]);
}


////////////////////////////////////////////////////////////////////////////////////////////////////

NSString* NSStringGenerateSHA1FromString(NSString *string) {
    if (! string) return nil;
    //sha1 hash the string
    const char *str = [string UTF8String];
    unsigned char outBuffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, strlen(str), outBuffer);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", outBuffer[i]];
    }
	
    return [NSString stringWithString:hash];
}

@end
