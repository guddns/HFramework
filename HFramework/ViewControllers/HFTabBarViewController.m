//
//  HFTabBarViewController.m
//  HFramework
//
//  Created by hug on 13. 7. 5..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HFTabBarViewController.h"
#import "HF_Precompile.h"
#import "UIView+Additions.h"
#import "HF_Dimensions.h"

@interface HFTabBarViewController ()

@end

@implementation HFTabBarViewController

@synthesize showTabBarCoverView = _showTabBarCoverView;
@synthesize buttonActionHooker = _buttonActionHooker;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (void)setTabBarCoverViewButtonWithType:(NSString *)aType
{
	if (_tabBarCoverView == nil) {
		_tabBarCoverView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
		[self.tabBar addSubview:_tabBarCoverView];
	}
	
	NSUInteger controllersCount = [self.viewControllers count];
	NSUInteger buttonWidth = _tabBarCoverView.width / controllersCount;
	
	for (int i = 0; i < controllersCount; i++) {
		UIImage *offImage = [UIImage imageNamed:[_offBtnImageNames objectAtIndex:i]];
		UIImage *onImage  = [UIImage imageNamed:[_onBtnImageNames objectAtIndex:i]];
		UIButton *btn = nil;
		
		if ([@"new" isEqualToString:aType]) {
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
			[btn setFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, _tabBarCoverView.height)];
			[btn setContentMode:UIViewContentModeScaleAspectFit];
			[btn setAdjustsImageWhenHighlighted:NO];
			[btn setTag:i];
			[btn addTarget:self action:@selector(tabBarButtonDidPush:) forControlEvents:UIControlEventTouchUpInside];
			[_tabBarCoverView addSubview:btn];
			
			UITabBarItem *tabBarItem = (UITabBarItem *)[self.tabBar.items objectAtIndex:i];
			tabBarItem.enabled = NO;
			tabBarItem.title = @"";
		} else {
			btn = [_tabBarCoverView.subviews objectAtIndex:i];
		}
		
		[btn setBackgroundImage:offImage forState:UIControlStateNormal] ;
		[btn setBackgroundImage:offImage forState:UIControlStateHighlighted];
		[btn setBackgroundImage:onImage  forState:UIControlStateSelected];
		
		if (self.selectedIndex == i) {
			[btn setBackgroundImage:onImage forState:UIControlStateNormal];
			[btn setSelected:YES];
		} else {
			[btn setSelected:NO];
		}
	}
}

- (void)setTabBarCoverViewWithPrefixImageName:(NSString *)prefixImageName
{
	_showTabBarCoverView = NO;
	
	NSUInteger controllersCount = [self.viewControllers count];
	_offBtnImageNames = [[NSMutableArray alloc] initWithCapacity:controllersCount];
	_onBtnImageNames  = [[NSMutableArray alloc] initWithCapacity:controllersCount];
	
	for (int i = 0; i < controllersCount; i++) {
		[_onBtnImageNames addObject:[NSString stringWithFormat:@"%@_%d_on.png", prefixImageName, i+1]];
		[_offBtnImageNames addObject:[NSString stringWithFormat:@"%@_%d_off.png", prefixImageName, i+1]];
	}
	
	[self setTabBarCoverViewButtonWithType:@"new"];
	
	_showTabBarCoverView = YES;
}

- (void)tabBarButtonDidPush:(id)sender
{
    BOOL shouldChange = YES;
	
	if (_buttonActionHooker && ![_buttonActionHooker shouldSelectTabBarButtonIndex:[sender tag]]) {
		shouldChange = NO;
	}
    
    if (shouldChange == YES && self.delegate) {
        if (![self.delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:[sender tag]]]) {
            shouldChange = NO;
        }
    }
    
    if (shouldChange) {
        if (self.selectedIndex == [sender tag]) {
            UINavigationController *navigationController = nil;
            navigationController = (UINavigationController *)[self.viewControllers objectAtIndex:self.selectedIndex];
            
            if ([navigationController isKindOfClass:[UINavigationController class]]) {
                [navigationController popToRootViewControllerAnimated:YES];
            }
        } else {
            [self setSelectedIndex:[sender tag]];
        }
        
        [self.delegate tabBarController:self didSelectViewController:[self.viewControllers objectAtIndex:[sender tag]]];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    if (_showTabBarCoverView) {
        [self setTabBarCoverViewButtonWithType:@"update"];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
	return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskPortrait;
}

- (void)dealloc {
	
}

@end
