//
//  HComboBox.m
//  HFramework
//
//  Created by hug on 13. 7. 31..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HComboBox.h"

@implementation HComboBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self initialize];
    }
    return self;
}

- (id)initWithBackgroundImage:(NSString *)imageName
{
	UIImage *image = [UIImage imageNamed:imageName];
	self = [self initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
	if (self) {
		UIImageView *backView = [[UIImageView alloc] initWithImage:image];
		[self insertSubview:backView atIndex:0];
	}
	return self;
}

- (void)initialize {
	_valueLabel = [[UILabel alloc] initWithFrame:self.bounds];
	_valueLabel.backgroundColor = [UIColor clearColor];
	_valueLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self addSubview:_valueLabel];
	
	_pickerView = [[UIPickerView alloc] init];
	_pickerView.showsSelectionIndicator = YES;
	_pickerView.dataSource = self;
	_pickerView.delegate = self;
	self.inputView = _pickerView;
}

- (void)setValues:(NSArray *)values
{
	_values = values;
	[_pickerView reloadAllComponents];
	if ([_values indexOfObject:_selectedValue] != NSNotFound) {
		[_pickerView selectRow:[_values indexOfObject:_selectedValue] inComponent:0 animated:NO];
	}
}

- (void)setSelectedValue:(NSString *)selectedValue
{
	_selectedValue = selectedValue;
	if ([_values indexOfObject:selectedValue] != NSNotFound) {
		[_pickerView selectRow:[_values indexOfObject:selectedValue] inComponent:0 animated:NO];
	}
}


#pragma mark - UIPickerView DataSource, Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.values count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [self.values objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	_selectedRow = row;
	_valueLabel.text = [self.values objectAtIndex:row];
	if ([_delegate respondsToSelector:@selector(comboBox:didChangedToValue:)]) {
		[_delegate comboBox:self didChangedToValue:[self.values objectAtIndex:row]];
	}
}


#pragma mark - Responder

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    [self becomeFirstResponder];
    return NO;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canResignFirstResponder {
    return YES;
}

@end
