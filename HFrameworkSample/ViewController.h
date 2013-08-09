//
//  ViewController.h
//  HFrameworkSample
//
//  Created by hug on 13. 7. 5..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (IBAction)modalTest:(id)sender;

@end
