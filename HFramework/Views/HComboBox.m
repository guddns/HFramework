//
//  HComboBox.m
//  HFramework
//
//  Created by hug on 13. 7. 31..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HComboBox.h"
#import "HF_Additions.h"

@interface HComboBox ()

@property (nonatomic, strong) UIPickerView *pickerView;
@property (readwrite, strong) UIView *inputView;

@end

@implementation HComboBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self initialize];
		self.leftInset = 5;
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
	_textLabel = [[UILabel alloc] initWithFrame:self.bounds];
	_textLabel.backgroundColor = [UIColor clearColor];
	_textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self addSubview:_textLabel];
	
	_pickerView = [[UIPickerView alloc] init];
	_pickerView.showsSelectionIndicator = NO;
	_pickerView.dataSource = self;
	_pickerView.delegate = self;
	_pickerView.exclusiveTouch = NO;
	self.inputView = _pickerView;
}

- (void)setLeftInset:(NSInteger)leftInset
{
	_leftInset = leftInset;
	_textLabel.frame = CGRectMake(_leftInset, 0, self.width - _leftInset, self.height);
}

- (void)setItems:(NSArray *)items
{
	_items = items;
	[_pickerView reloadAllComponents];
	_textLabel.text = [self.items objectAtIndex:0];
}

- (void)setSelectedValue:(NSString *)selectedValue
{
	_selectedItem = selectedValue;
	if ([_items indexOfObject:selectedValue] != NSNotFound) {
		[_pickerView selectRow:[_items indexOfObject:selectedValue] inComponent:0 animated:NO];
	}
}

- (UIView *)inputAccessoryView
{
	return [self.viewController inputAccessoryView];
}

- (void)toggleSelection:(UITapGestureRecognizer *)recognizer {
	UITableViewCell *selectedCell = (UITableViewCell *) recognizer.view;
	_selectedRow = selectedCell.tag;
	
	for (int i = 0; i < [_pickerView numberOfRowsInComponent:0]; i++) {
		UITableViewCell *cell = (UITableViewCell *)[_pickerView viewForRow:i forComponent:0];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	[selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
	
	[_pickerView selectRow:_selectedRow inComponent:0 animated:YES];
	
	if (_delegate && [_delegate respondsToSelector:@selector(comboBox:didChangedToValue:)]) {
		[_delegate comboBox:self didChangedToValue:nil];
	}
}


#pragma mark - UIPickerView DataSource, Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.items count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [self.items objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	UITableViewCell *cell = (UITableViewCell *)view;
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
		[cell setBounds:CGRectMake(0, 0, cell.frame.size.width - 20, 44)];
		[cell setBackgroundColor:[UIColor clearColor]];

		UITapGestureRecognizer * singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSelection:)];
		singleTapGestureRecognizer.numberOfTapsRequired = 1;
		[cell addGestureRecognizer:singleTapGestureRecognizer];
	}
	
	cell.tag = row;
	
	//	if ([selectedItems indexOfObject:[NSNumber numberWithInt:row]] != NSNotFound) {
	//		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	//	} else {
	//		[cell setAccessoryType:UITableViewCellAccessoryNone];
	//	}
	
	cell.textLabel.text = [_items objectAtIndex:row];
	
	return cell;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	//	_selectedRow = row;
	//	_textLabel.text = [self.values objectAtIndex:row];
	//	if ([_delegate respondsToSelector:@selector(comboBox:didChangedToValue:)]) {
	//		[_delegate comboBox:self didChangedToValue:[self.values objectAtIndex:row]];
	//	}
}


#pragma mark - Responder

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canResignFirstResponder {
    return YES;
}

@end
