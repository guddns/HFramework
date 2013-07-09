//
//  HFNavigationManager.h
//  HFramework
//
//  Created by hug on 13. 7. 9..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HF_Precompile.h"
#import "HF_Singleton.h"

@interface HFNavigationManager : NSObject

@property (nonatomic, weak) UIViewController *topViewController;
@property (nonatomic, strong) id parameter;

AS_SINGLETON(HFNavigationManager)

- (void)pushViewControllerForClassName:(NSString *)aViewControllerClassName animated:(BOOL)animated;

- (void)popViewControllerAnimated:(BOOL)animated;

@end
