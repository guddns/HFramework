//
//  HModal.m
//  HFramework
//
//  Created by hug on 13. 8. 8..
//  Copyright (c) 2013년 hug. All rights reserved.
//

#import "HModal.h"
#import <QuartzCore/QuartzCore.h>

CGFloat const kFadeInAnimationDuration = 0.3;
CGFloat const kTransformPart1AnimationDuration = 0.2;
CGFloat const kTransformPart2AnimationDuration = 0.1;
NSString *const KGModalGradientViewTapped = @"KGModalGradientViewTapped";

@interface KGModalGradientView : UIView
@end

@interface KGModalContainerView : UIView
@property (weak, nonatomic) CALayer *styleLayer;
@property (strong, nonatomic) UIColor *modalBackgroundColor;
@end

@interface KGModalViewController : UIViewController
@property (weak, nonatomic) KGModalGradientView *styleView;
@end

@interface HModal()
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *contentViewController;
@property (weak, nonatomic) KGModalViewController *viewController;
@property (weak, nonatomic) KGModalContainerView *containerView;
@property (weak, nonatomic) UIView *contentView;
@end

@implementation HModal

+ (instancetype)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    if(!(self = [super init])){
        return nil;
    }
    
    self.shouldRotate = YES;
    self.tapOutsideToDismiss = YES;
    self.animateWhenDismissed = YES;
    self.modalBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    return self;
}

- (void)showWithContentView:(UIView *)contentView{
    [self showWithContentView:contentView andAnimated:YES];
}

- (void)showWithContentViewController:(UIViewController *)contentViewController{
    [self showWithContentViewController:contentViewController andAnimated:YES];
}

- (void)showWithContentViewController:(UIViewController *)contentViewController andAnimated:(BOOL)animated{
    self.contentViewController = contentViewController;
    [self showWithContentView:contentViewController.view andAnimated:YES];
}

- (void)showWithContentView:(UIView *)contentView andAnimated:(BOOL)animated {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    
    KGModalViewController *viewController = [[KGModalViewController alloc] init];
    self.window.rootViewController = viewController;
    self.viewController = viewController;
    
    CGFloat padding = 17;
    CGRect containerViewRect = CGRectInset(contentView.bounds, -padding, -padding);
    containerViewRect.origin.x = containerViewRect.origin.y = 0;
    containerViewRect.origin.x = round(CGRectGetMidX(self.window.bounds)-CGRectGetMidX(containerViewRect));
    containerViewRect.origin.y = round(CGRectGetMidY(self.window.bounds)-CGRectGetMidY(containerViewRect));
    KGModalContainerView *containerView = [[KGModalContainerView alloc] initWithFrame:containerViewRect];
    containerView.modalBackgroundColor = self.modalBackgroundColor;
    containerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    containerView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    contentView.frame = (CGRect){padding, padding, contentView.bounds.size};
    [containerView addSubview:contentView];
    [viewController.view addSubview:containerView];
    self.containerView = containerView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapCloseAction:) name:KGModalGradientViewTapped object:nil];
    
    // The window has to be un-hidden on the main thread
    // This will cause the window to display
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.window makeKeyAndVisible];
        
        if (animated) {
            viewController.styleView.alpha = 0;
			
            [UIView animateWithDuration:kFadeInAnimationDuration animations:^{
                viewController.styleView.alpha = 1;
            }];
            
            containerView.alpha = 0;
            containerView.layer.shouldRasterize = YES;
            containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
			
            [UIView animateWithDuration:kTransformPart1AnimationDuration animations:^{
                containerView.alpha = 1;
                containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:kTransformPart2AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    containerView.alpha = 1;
                    containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                } completion:^(BOOL finished2) {
                    containerView.layer.shouldRasterize = NO;
                }];
            }];
        }
    });
}

- (void)closeAction:(id)sender{
    [self hideAnimated:self.animateWhenDismissed];
}

- (void)tapCloseAction:(id)sender{
    if(self.tapOutsideToDismiss){
        [self hideAnimated:self.animateWhenDismissed];
    }
}

- (void)hide{
    [self hideAnimated:YES];
}

- (void)hideWithCompletionBlock:(void(^)())completion{
    [self hideAnimated:YES withCompletionBlock:completion];
}

- (void)hideAnimated:(BOOL)animated{
    [self hideAnimated:animated withCompletionBlock:nil];
}

- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)())completion{
    if(!animated){
        [self cleanup];
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kFadeInAnimationDuration animations:^{
            self.viewController.styleView.alpha = 0;
        }];
        
        self.containerView.layer.shouldRasterize = YES;
        [UIView animateWithDuration:kTransformPart2AnimationDuration animations:^{
            self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:kTransformPart1AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.containerView.alpha = 0;
                self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
            } completion:^(BOOL finished2){
                [self cleanup];
                if(completion){
                    completion();
                }
            }];
        }];
    });
}

- (void)cleanup{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.containerView removeFromSuperview];
    [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
    [self.window removeFromSuperview];
    self.contentViewController = nil;
    self.window = nil;
}

- (void)setModalBackgroundColor:(UIColor *)modalBackgroundColor{
    if(_modalBackgroundColor != modalBackgroundColor){
        _modalBackgroundColor = modalBackgroundColor;
        self.containerView.modalBackgroundColor = modalBackgroundColor;
    }
}

- (void)dealloc{
    [self cleanup];
}

@end

@implementation KGModalViewController

- (void)loadView{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    KGModalGradientView *styleView = [[KGModalGradientView alloc] initWithFrame:self.view.bounds];
    styleView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    styleView.opaque = NO;
    [self.view addSubview:styleView];
    self.styleView = styleView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return [[HModal sharedInstance] shouldRotate];
}

@end

@implementation KGModalContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    if(!(self = [super initWithFrame:frame])){
        return nil;
    }
    
    return self;
}

- (void)setModalBackgroundColor:(UIColor *)modalBackgroundColor{
    if(_modalBackgroundColor != modalBackgroundColor){
        _modalBackgroundColor = modalBackgroundColor;
        self.styleLayer.backgroundColor = [modalBackgroundColor CGColor];
    }
}

@end

@implementation KGModalGradientView

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:KGModalGradientViewTapped object:nil];
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if([[HModal sharedInstance] backgroundDisplayStyle] == KGModalBackgroundDisplayStyleSolid){
        [[UIColor colorWithWhite:0 alpha:0.55] set];
        CGContextFillRect(context, self.bounds);
    }else{
        CGContextSaveGState(context);
        size_t gradLocationsNum = 2;
        CGFloat gradLocations[2] = {0.0f, 1.0f};
        CGFloat gradColors[8] = {0, 0, 0, 0.3, 0, 0, 0, 0.8};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
        CGColorSpaceRelease(colorSpace), colorSpace = NULL;
        CGPoint gradCenter= CGPointMake(round(CGRectGetMidX(self.bounds)), round(CGRectGetMidY(self.bounds)));
        CGFloat gradRadius = MAX(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        CGContextDrawRadialGradient(context, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
        CGGradientRelease(gradient), gradient = NULL;
        CGContextRestoreGState(context);
    }
}

@end