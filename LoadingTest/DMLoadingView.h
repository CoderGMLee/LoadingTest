//
//  DMLoadingLayer.h
//  LoadingTest
//
//  Created by GM on 16/1/18.
//  Copyright © 2016年 GM. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DMLoadingStep) {
    DMLoadingStepOne,
    DMLoadingStepTwo,
    DMLoadingStepThree,
    DMLoadingStepFour,
    DMLoadingStepFive,
    DMLoadingStepSix
};

@interface DMLoadingView : UIView

@property (nonatomic, assign, readonly)double progress;
@property (nonatomic, assign)DMLoadingStep step;

- (void)startAnimaiton;

- (void)stopAnimation;

- (void)setLineColor:(UIColor *)color;

@end
