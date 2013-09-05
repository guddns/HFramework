//
//  ViewController.m
//  HFrameworkSample
//
//  Created by hug on 13. 7. 5..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "ViewController.h"
#import "HFramework.h"
#import "HComboBox.h"
#import "HInputAccessoryView.h"
#import "TestCell.h"
#import "HModal.h"
#import <MapKit/MapKit.h>

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
	
//	_tableView.allowsMultipleSelectionDuringEditing = YES;
////	_tableView.allowsMultipleSelection = YES;
//	_tableView.rowHeight = 50;
//	_tableView.editing = YES;
	
	_scrollView.contentSize = CGSizeMake(200, 600);
	
	MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	mapView.showsUserLocation = YES;
	mapView.delegate = self;
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.12;
	span.longitudeDelta = 0.12;
	
	CLLocationCoordinate2D location = mapView.userLocation.coordinate;
	location.latitude = 37.514849;
    location.longitude = 126.954063;
	
	region.span = span;
	region.center = location;
	
	[mapView setRegion:region animated:YES];
	[mapView regionThatFits:region];
	
	MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = mapView.userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
	[mapView addAnnotation:point];
	
//	[self.view addSubview:mapView];
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

- (void)modalTest:(id)sender
{
	[[HModal sharedInstance] showWithContentView:_comboBox];	
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *annotationViewReuseIdentifier = @"annotationViewReuseIdentifier";
	
    MKAnnotationView *annotationView = (MKAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIdentifier];
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIdentifier];
    }
	
    annotationView.image = [UIImage imageNamed:@"tab_1_on.png"];
    annotationView.annotation = annotation;
	
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
	[UIView animateWithDuration:0.2 animations:^{
		view.height -= 5;
	}];
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
	[UIView animateWithDuration:0.2 animations:^{
		view.height += 5;
	}];
}


@end
