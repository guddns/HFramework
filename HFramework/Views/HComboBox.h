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

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) NSString *selectedValue;
@property (nonatomic, weak) id<HComboBoxDelegate> delegate;

@property (readwrite, strong) UIView *inputView;
@property (readwrite, strong) UIView *inputAccessoryView;

@end

@protocol HComboBoxDelegate <NSObject>
@optional

- (void)comboBox:(HComboBox *)comboBox didChangedToValue:(NSString *)value;

@end
