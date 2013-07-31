//
//  HInputAccessoryView.h
//  HFramework
//
//  Created by hug on 13. 7. 31..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HInputAccessoryView : UIView

@property (nonatomic, strong) NSArray *responders;
@property (nonatomic, assign) BOOL hasDoneButton;

- (id)initWithResponders:(NSArray *)responders;

@end
