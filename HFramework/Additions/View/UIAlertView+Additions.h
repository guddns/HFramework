//
//  UIAlertView+Additions.h
//  HFramework
//
//  Created by hug on 13. 6. 17..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VoidBlock)();

typedef void (^DismissBlock)(int buttonIndex);
typedef void (^CancelBlock)();


////////////////////////////////////////////////////////////////////////////////////////////////////

@interface UIAlertView (Additions)

@property (copy, nonatomic) DismissBlock dismissBlock;
@property (copy, nonatomic) CancelBlock cancelBlock;

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
							message:(NSString *)message;

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
							message:(NSString *)message
				  cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
							message:(NSString *)message
				  cancelButtonTitle:(NSString *)cancelButtonTitle
				  otherButtonTitles:(NSArray *)otherButtons
						  onDismiss:(DismissBlock)dismissed
						   onCancel:(CancelBlock)cancelled;

@end
