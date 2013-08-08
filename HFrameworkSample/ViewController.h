//
//  ViewController.h
//  HFrameworkSample
//
//  Created by hug on 13. 7. 5..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (IBAction)modalTest:(id)sender;

@end
