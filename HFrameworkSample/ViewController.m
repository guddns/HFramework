//
//  ViewController.m
//  HFrameworkSample
//
//  Created by hug on 13. 7. 5..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "ViewController.h"
#import "HComboBox.h"
#import "HInputAccessoryView.h"
#import "TestCell.h"

@interface ViewController ()

@property (nonatomic, strong) HInputAccessoryView *inputAccessoryView;

@property (nonatomic, strong) HComboBox *comboBox;
@property (nonatomic, strong) UITextField *nameField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//	self.inputAccessoryView = [[HInputAccessoryView alloc] init];

	NSArray *values = @[@"test", @"test2"];
	
	_comboBox = [[HComboBox alloc] initWithBackgroundImage:@"select_box_car_use.png"];
	_comboBox.center = CGPointMake(100, 100);
	_comboBox.items = values;
	[self.view addSubview:_comboBox];
	
	UILabel *label = [[UILabel alloc] init];
	label.text = @"TEST";
	[label sizeToFit];
	[self.view addSubview:label];
	
	_nameField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 100, 30)];
	_nameField.backgroundColor = [UIColor yellowColor];
	[self.view addSubview:_nameField];
	
	_inputAccessoryView = [[HInputAccessoryView alloc] initWithResponders:@[_nameField, _comboBox]];
	
	_tableView.allowsMultipleSelectionDuringEditing = YES;
//	_tableView.allowsMultipleSelection = YES;
	_tableView.rowHeight = 50;
	_tableView.editing = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tototo"];
	if (cell == nil) {
		cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tototo"];
		UILabel *aView = [[UILabel alloc] initWithFrame:cell.bounds];
		aView.text = @"TEST";
		[cell.contentView addSubview:aView];
	}
	
	cell.multipleSelectionBackgroundView = [[UIImageView alloc] init];
	
//	cell.textLabel.text = @"test";
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
	NSLog(@"%i", selectedCell.selected);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
	NSLog(@"%i", selectedCell.selected);
}

@end
