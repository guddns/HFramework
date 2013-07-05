//
//  AppDelegate.h
//  HFrameworkSample
//
//  Created by hug on 13. 7. 5..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFramework.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HFTabBarViewController *tabBarViewController;
@property (strong, nonatomic) ViewController *viewController;

@end
