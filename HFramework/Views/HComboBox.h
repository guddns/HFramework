//
//  HComboBox.h
//  HFramework
//
//  Created by hug on 13. 7. 31..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HComboBoxDelegate;

@interface HComboBox : UIControl <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) NSInteger leftInset;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, strong) NSString *selectedItem;
@property (nonatomic, weak) id<HComboBoxDelegate> delegate;

- (id)initWithBackgroundImage:(NSString *)imageName;

@end

@protocol HComboBoxDelegate <NSObject>
@optional

- (void)comboBox:(HComboBox *)comboBox didChangedToValue:(NSString *)value;

@end
