//
//  DMLoadingLayer.h
//  LoadingTest
//
//  Created by 李国民 on 16/1/18.
//  Copyright © 2016年 李国民. All rights reserved.
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
