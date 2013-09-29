//
//  CustomIOS7AlertView.m
//  CustomIOS7AlertView
//
//  Created by Richard on 20/09/2013.
//  Copyright (c) 2013 Wimagguc.
//
//  Lincesed under The MIT License (MIT)
//  http://opensource.org/licenses/MIT
//

#import "CustomIOS7AlertView.h"

const static CGFloat kCustomIOS7AlertViewDefaultButtonHeight       = 50;
const static CGFloat kCustomIOS7AlertViewDefaultButtonSpacerHeight =  1;
const static CGFloat kCustomIOS7AlertViewCornerRadius              =  7;

@interface CustomIOS7AlertView()

@property (nonatomic, strong) UIView *parentView;    // The parent view this 'dialog' is attached to
@property (nonatomic, strong) UIView *dialogView;    // Dialog's container view
@property (nonatomic, strong) UIView *buttonView;    // Buttons on the bottom of the dialog

@property (nonatomic, strong) NSArray *buttonTitles;

@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) CGFloat buttonSpacerHeight;

@property (nonatomic, assign) BOOL useMotionEffects;

@end

@implementation CustomIOS7AlertView

- (id)initWithParentView:(UIView *)parentView
{
    return [self initWithParentView:parentView
                   useMotionEffects:YES];
}

- (id)initWithParentView:(UIView *)parentView
        useMotionEffects:(BOOL)useMotionEffects
{
    self = [super initWithFrame:parentView.frame];
    
    if (self) {
        self.parentView = parentView;
        self.delegate = self;
        self.buttonTitles = @[@"Close"];
        self.useMotionEffects = useMotionEffects;
    }
    return self;
}

// Create the dialog view, and animate opening the dialog
- (void)show
{
    self.dialogView = [self createContainerView];

    if (self.useMotionEffects)
        [self applyMotionEffects];
    
    self.dialogView.layer.opacity = 0.5f;
    self.dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self addSubview:self.dialogView];
    [self.parentView addSubview:self];
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         self.dialogView.layer.opacity = 1.0f;
                         self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];
}

// Button has touched
- (IBAction)customIOS7dialogButtonTouchUpInside:(id)sender
{
    [self.delegate customIOS7dialogButtonTouchUpInside:self
                                  clickedButtonAtIndex:[sender tag]];
}

// Default button behaviour
- (void)customIOS7dialogButtonTouchUpInside:(CustomIOS7AlertView *)alertView
                       clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Clicked! %d, %d", buttonIndex, [alertView tag]);
    [self close];
}

// Dialog close animation then cleaning and removing the view from the parent
- (void)close
{
    self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    self.dialogView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         self.dialogView.layer.transform = CATransform3DMakeScale(0.6f, 0.6f, 1.0);
                         self.dialogView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
	 ];
}

- (void)setSubView: (UIView *)subView
{
    self.containerView = subView;
}

// Creates the container view here: create the dialog, then add the custom content and buttons
- (UIView *)createContainerView
{
    if ([self.buttonTitles count] > 0) {
        self.buttonHeight       = kCustomIOS7AlertViewDefaultButtonHeight;
        self.buttonSpacerHeight = kCustomIOS7AlertViewDefaultButtonSpacerHeight;
    } else {
        self.buttonHeight = 0;
        self.buttonSpacerHeight = 0;
    }
    
    if (self.containerView == NULL) {
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    }
    
    CGFloat dialogWidth  = self.containerView.frame.size.width;
    CGFloat dialogHeight = self.containerView.frame.size.height + self.buttonHeight + self.buttonSpacerHeight;
    
    CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationIsLandscape(deviceOrientation)) {
        CGFloat tmp = screenWidth;
        screenWidth = screenHeight;
        screenHeight = tmp;
    }
    
    // For the black background
    [self setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    // This is the dialog's container; we attach the custom content and the buttons to this one
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenWidth - dialogWidth) / 2, (screenHeight - dialogHeight) / 2, dialogWidth, dialogHeight)];
    
    
    // First, we style the dialog to match the iOS7 UIAlertView >>>
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = dialogContainer.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0f] CGColor],
                       (id)[[UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0f] CGColor],
                       (id)[[UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0f] CGColor],
                       nil];

    CGFloat cornerRadius = kCustomIOS7AlertViewCornerRadius;
    gradient.cornerRadius = cornerRadius;
    [dialogContainer.layer insertSublayer:gradient atIndex:0];
    
    dialogContainer.layer.cornerRadius = cornerRadius;
    dialogContainer.layer.borderColor = [[UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f] CGColor];
    dialogContainer.layer.borderWidth = 1;
    dialogContainer.layer.shadowRadius = cornerRadius + 5;
    dialogContainer.layer.shadowOpacity = 0.1f;
    dialogContainer.layer.shadowOffset = CGSizeMake(0 - (cornerRadius+5)/2, 0 - (cornerRadius+5)/2);
    // ^^^
    
    // There is a line above the button
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, dialogContainer.bounds.size.height - self.buttonHeight - self.buttonSpacerHeight,
                                                                dialogContainer.bounds.size.width, self.buttonSpacerHeight)];
    lineView.backgroundColor = [UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f];
    [dialogContainer addSubview:lineView];
    // ^^^

    // Add the custom container if there is any
    [dialogContainer addSubview:self.containerView];

    // Add the buttons too
    [self addButtonsToView:dialogContainer];

    return dialogContainer;
}

- (void)addButtonsToView: (UIView *)container
{
    CGFloat buttonWidth = container.bounds.size.width / [self.buttonTitles count];

    for (int i=0; i<[self.buttonTitles count]; i++) {

        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

        [closeButton setFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - self.buttonHeight, buttonWidth, self.buttonHeight)];

        [closeButton addTarget:self action:@selector(customIOS7dialogButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTag:i];

        [closeButton setTitle:[self.buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.5f] forState:UIControlStateHighlighted];
        [closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [closeButton.layer setCornerRadius:kCustomIOS7AlertViewCornerRadius];

        [container addSubview:closeButton];
    }
}

// Add motion effects
- (void)applyMotionEffects {
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
        return;
    
    static const CGFloat effectExtent = 10.;
    
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
  horizontalEffect.minimumRelativeValue = @(-effectExtent);
  horizontalEffect.maximumRelativeValue = @( effectExtent);
  
  UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
  verticalEffect.minimumRelativeValue = @(-effectExtent);
  verticalEffect.maximumRelativeValue = @( effectExtent);
  
  UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
  motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
  
  [self.dialogView addMotionEffect:motionEffectGroup];
}

@end
