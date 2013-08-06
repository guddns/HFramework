//
//  HInputAccessoryView.m
//  HFramework
//
//  Created by hug on 13. 7. 31..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HInputAccessoryView.h"

static NSString * UIKitLocalizedString(NSString *string)
{
	NSBundle *UIKitBundle = [NSBundle bundleForClass:[UIApplication class]];
	return UIKitBundle ? [UIKitBundle localizedStringForKey:string value:string table:nil] : string;
}

static NSArray * EditableTextInputsInView(UIView *view)
{
	NSMutableArray *textInputs = [NSMutableArray new];
	for (UIView *subview in view.subviews)
	{
		BOOL isTextField = [subview isKindOfClass:[UITextField class]];
		BOOL isEditableTextView = [subview isKindOfClass:[UITextView class]] && [(UITextView *)subview isEditable];
		if (isTextField || isEditableTextView)
			[textInputs addObject:subview];
		else
			[textInputs addObjectsFromArray:EditableTextInputsInView(subview)];
	}
	return textInputs;
}

@interface HInputAccessoryView ()

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation HInputAccessoryView

- (id)init
{
	self = [super init];
	if (self) {
		
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [self initWithResponders:nil];
	if (self) {
		
	}
	return self;
}

- (id)initWithResponders:(NSArray *)responders
{
	self = [super initWithFrame:CGRectZero];
	if (self) {
		_responders = responders;
		
		UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"이전", @"다음"]];
		segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
		segmentedControl.momentary = YES;
		[segmentedControl addTarget:self action:@selector(selectAdjacentResponder:) forControlEvents:UIControlEventValueChanged];
		
		UIBarButtonItem *segmentedControlBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
		
		UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		
		_toolbar = [[UIToolbar alloc] init];
		_toolbar.barStyle = UIBarStyleBlack;
		_toolbar.translucent = YES;
		_toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_toolbar.items = @[segmentedControlBarButtonItem, flexibleSpace];
		[self addSubview:_toolbar];
		
		[self setHasDoneButton:YES];
		
		self.frame = _toolbar.frame = (CGRect){CGPointZero, [_toolbar sizeThatFits:CGSizeZero]};
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
	}
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setHasDoneButton:(BOOL)hasDoneButton
{
	[self setHasDoneButton:hasDoneButton animated:NO];
}

- (void)setHasDoneButton:(BOOL)hasDoneButton animated:(BOOL)animated
{
	if (_hasDoneButton == hasDoneButton)
		return;
	
	[self willChangeValueForKey:@"hasDoneButton"];
	_hasDoneButton = hasDoneButton;
	[self didChangeValueForKey:@"hasDoneButton"];
	
	NSArray *items;
	if (hasDoneButton)
		items = [_toolbar.items arrayByAddingObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnTapped:)]];
	else
		items = [_toolbar.items subarrayWithRange:NSMakeRange(0, 2)];
	
	[_toolbar setItems:items animated:animated];
}

- (void)updateSegmentedControl
{
	NSArray *responders = self.responders;
	if (responders.count == 0)
		return;
	
	UISegmentedControl *segmentedControl = (UISegmentedControl *)[_toolbar.items[0] customView];
	BOOL isFirst = [[responders objectAtIndex:0] isFirstResponder];
	BOOL isLast = [[responders lastObject] isFirstResponder];
	[segmentedControl setEnabled:!isFirst forSegmentAtIndex:0];
	[segmentedControl setEnabled:!isLast forSegmentAtIndex:1];
}

- (void) willMoveToWindow:(UIWindow *)window
{
	if (!window)
		return;
	
	[self updateSegmentedControl];
}

- (void) textInputDidBeginEditing:(NSNotification *)notification
{
	[self updateSegmentedControl];
}

- (NSArray *) responders
{
	if (_responders)
		return _responders;
	
	NSArray *textInputs = EditableTextInputsInView([[UIApplication sharedApplication] keyWindow]);
	return [textInputs sortedArrayUsingComparator:^NSComparisonResult(UIView *textInput1, UIView *textInput2) {
		UIView *commonAncestorView = textInput1.superview;
		while (commonAncestorView && ![textInput2 isDescendantOfView:commonAncestorView])
			commonAncestorView = commonAncestorView.superview;
		
		CGRect frame1 = [textInput1 convertRect:textInput1.bounds toView:commonAncestorView];
		CGRect frame2 = [textInput2 convertRect:textInput2.bounds toView:commonAncestorView];
		return [@(CGRectGetMinY(frame1)) compare:@(CGRectGetMinY(frame2))];
	}];
}



#pragma mark - Actions

- (void) selectAdjacentResponder:(UISegmentedControl *)sender
{
	NSArray *firstResponders = [self.responders filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UIResponder *responder, NSDictionary *bindings) {
		return [responder isFirstResponder];
	}]];
	
	UIResponder *firstResponder = [firstResponders lastObject];
	NSInteger offset = sender.selectedSegmentIndex == 0 ? -1 : +1;
	NSInteger firstResponderIndex = [self.responders indexOfObject:firstResponder];
	NSInteger adjacentResponderIndex = firstResponderIndex != NSNotFound ? firstResponderIndex + offset : NSNotFound;
	UIResponder *adjacentResponder = nil;
	if (adjacentResponderIndex >= 0 && adjacentResponderIndex < (NSInteger)[self.responders count])
		adjacentResponder = [self.responders objectAtIndex:adjacentResponderIndex];
	
	[adjacentResponder becomeFirstResponder];
	[self updateSegmentedControl];
}

- (void) doneBtnTapped:(id)sender
{
	[[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
