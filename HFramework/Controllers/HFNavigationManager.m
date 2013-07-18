//
//  HFNavigationManager.m
//  HFramework
//
//  Created by hug on 13. 7. 9..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HFNavigationManager.h"

@implementation HFNavigationManager

DEF_SINGLETON(HFNavigationManager)

- (void)pushViewControllerForClassName:(NSString *)aViewControllerClassName animated:(BOOL)animated
{
	Class targetClass = NSClassFromString(aViewControllerClassName);
	id viewController = [[targetClass alloc] initWithNibName:aViewControllerClassName bundle:nil];
	[_topViewController.navigationController pushViewController:(UIViewController *)viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[_topViewController.navigationController pushViewController:(UIViewController *)viewController animated:animated];
}

- (void)popViewControllerAnimated:(BOOL)animated
{
	[_topViewController.navigationController popViewControllerAnimated:animated];
}

@end
