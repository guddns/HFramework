//
//  HFTabBarViewController.h
//  HFramework
//
//  Created by hug on 13. 7. 5..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HF_Additions.h"

@protocol HFTabBarViewControllerActionHooker;

@interface HFTabBarViewController : UITabBarController
{
	UIView *_tabBarCoverView;
	
	NSMutableArray *_offBtnImageNames;
	NSMutableArray *_onBtnImageNames;
	BOOL _showTabBarCoverView;
}

@property (assign, getter = isShowTabBarCoverView) BOOL showTabBarCoverView;
@property (nonatomic, assign) id<HFTabBarViewControllerActionHooker> buttonActionHooker;

- (void)setTabBarCoverViewWithPrefixImageName:(NSString *)prefixImageName;

@end


@protocol HFTabBarViewControllerActionHooker <NSObject>

- (BOOL)shouldSelectTabBarButtonIndex:(NSUInteger)index;

@end
