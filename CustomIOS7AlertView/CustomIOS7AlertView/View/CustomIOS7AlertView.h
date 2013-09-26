//
//  CustomIOS7AlertView.h
//  CustomIOS7AlertView
//
//  Created by Richard on 20/09/2013.
//  Copyright (c) 2013 Wimagguc.
//
//  Lincesed under The MIT License (MIT)
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

@interface CustomIOS7AlertView : UIView

@property (nonatomic, strong) UIView *containerView; // Container within the dialog (place your ui elements here)
@property (nonatomic, assign) id delegate;

- (id)initWithParentView: (UIView *)parentView;
- (id)initWithParentView:(UIView *)parentView
           motionEffects:(BOOL)motionEffects;

- (void)show;
- (void)close;
- (void)setButtonTitles:(NSArray *)buttonTitles;

- (IBAction)customIOS7dialogButtonTouchUpInside:(id)sender;

@end
