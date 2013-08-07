//
//  TestCell.m
//  HFramework
//
//  Created by hug on 13. 8. 7..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
	
    for (UIView* subview in [self subviews]) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellEditControl"]) {
			NSLog(@"%@", NSStringFromCGRect(subview.frame));
            [subview setHidden:YES];
        }
    }
	
    if ([self isEditing]) {
        // Show the custom view however you want.
        // The value of [self isSelected] will be useful...
    } else {
        // Hide the custom view.
    }
}

@end
