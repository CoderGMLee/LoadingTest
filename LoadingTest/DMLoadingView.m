//
//  DMLoadingLayer.m
//  LoadingTest
//
//  Created by 李国民 on 16/1/18.
//  Copyright © 2016年 李国民. All rights reserved.
//

#import "DMLoadingView.h"

#define KCenter CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
#define KRadius         17
#define KMultipy        0.8
#define KPointRadius    4
#define KRotateDuration 0.5
#define KLineWith       2
#define KFrameInterval  2

@interface DMLoadingView()
{
    CGContextRef _context;
    CABasicAnimation * _rotateAnimaiton;
    CADisplayLink * _displayLink;
    UIColor * _color;
}

@end

@implementation DMLoadingView

- (instancetype)init{

    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addObserver:self forKeyPath:@"step" options:NSKeyValueObservingOptionNew context:nil];
        [self config];
    }
    return self;
}
- (void)config{
    _color = [UIColor colorWithRed:0.91 green:0.31 blue:0 alpha:1];
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLayer)];
        _displayLink.frameInterval = KFrameInterval;
        _displayLink.paused = YES;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}
- (void)updateLayer{

    switch (self.step) {
        case DMLoadingStepOne:
        {
            if (self.progress < 0.9) {
                _progress += 0.1;
            }else if (self.progress >= 0.9){
                self.step = DMLoadingStepTwo;
            }

        }
            break;
        case DMLoadingStepTwo:
        {
            if (self.progress < 0.9) {
                _progress += 0.1;
            }
        }
            break;
        case DMLoadingStepThree:
        {
            if (self.progress < 1.1) {
                _progress += 0.1;
            }else if (self.progress >= 1.1){
                self.step = DMLoadingStepFour;
            }
        }
            break;

        case DMLoadingStepFour:
        {
            if (self.progress > 0.2) {
                _progress -= 0.1;
            }else if (self.progress <= 0.2){
                self.step = DMLoadingStepFive;
            }
        }
            break;
        case DMLoadingStepFive:
        {
            if (self.progress > 0.08) {
                _progress -= 0.04;
            }
        }
            break;
        case DMLoadingStepSix:
        {
            if (self.progress > 0.1) {
                _progress -= 0.1;
            }else if (self.progress <= 0.1){
                self.step = DMLoadingStepOne;
            }
        }
            break;
    }
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{

    _context = UIGraphicsGetCurrentContext();
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    switch (_step) {
        case DMLoadingStepOne:
        {
            [self step1];
        }
            break;
        case DMLoadingStepTwo:
        {
            [self step2];
        }
            break;
        case DMLoadingStepThree:
        {
            [self step3];
        }
            break;
        case DMLoadingStepFour:
        {
            [self step4];
        }
            break;
        case DMLoadingStepFive:
        {
            [self step5];
        }
            break;
        case DMLoadingStepSix:
        {
            [self step6];
        }
            break;
    }
    CGContextSetStrokeColorWithColor(_context, _color.CGColor);

    CGContextSetLineWidth(_context, KLineWith);
    CGContextStrokePath(_context);

    CGContextSetStrokeColorWithColor(_context, [UIColor blackColor].CGColor);
    CGContextStrokePath(_context);
}


- (void)step1{

    CGPoint center = KCenter;
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(center.x, center.y + KRadius * _progress) radius:KPointRadius * _progress startAngle:0 endAngle:M_2_PI clockwise:YES];
    CGContextAddPath(_context, path.CGPath);

    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:CGPointMake(center.x, center.y - KRadius * _progress) radius:KPointRadius * _progress startAngle:0 endAngle:M_2_PI clockwise:YES];
    CGContextAddPath(_context, path1.CGPath);

    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:CGPointMake(center.x + KRadius * _progress ,center.y) radius:KPointRadius * _progress startAngle:0 endAngle:M_2_PI clockwise:YES];
    CGContextAddPath(_context, path2.CGPath);

    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 addArcWithCenter:CGPointMake(center.x - KRadius * _progress, center.y) radius:KPointRadius * _progress startAngle:0 endAngle:M_2_PI clockwise:YES];
    CGContextAddPath(_context, path3.CGPath);

    CGContextSetAlpha(_context, _progress);

    NSString * centerPath = NSStringFromCGPoint(CGPointMake(center.x, center.y + KRadius * _progress));
    NSLog(@"centerPaht  : %@   progress : %f",centerPath,_progress);
}

- (void)step2{

    UIBezierPath * path = [UIBezierPath bezierPath];
    CGFloat increment = M_PI_2 * _progress * KMultipy;


    //起点不变 终点值变化
    [path addArcWithCenter:KCenter radius:KRadius startAngle:0 endAngle:increment clockwise:YES];
    CGContextAddPath(_context, path.CGPath);

    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:KCenter radius:KRadius startAngle:M_PI_2 endAngle:M_PI_2 + increment clockwise:YES];
    CGContextAddPath(_context, path1.CGPath);

    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:KCenter radius:KRadius startAngle:M_PI endAngle:M_PI + increment clockwise:YES];
    CGContextAddPath(_context, path2.CGPath);

    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 addArcWithCenter:KCenter radius:KRadius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + increment clockwise:YES];
    CGContextAddPath(_context, path3.CGPath);

}

- (void)step3{
    //起点值变化  终点值不变

    CGFloat increment = M_PI_2 * _progress * KMultipy;
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path addArcWithCenter:KCenter radius:KRadius startAngle:increment endAngle:M_PI_2 clockwise:YES];
    CGContextAddPath(_context, path.CGPath);

    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:KCenter radius:KRadius startAngle:M_PI_2 + increment endAngle:M_PI clockwise:YES];
    CGContextAddPath(_context, path1.CGPath);

    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:KCenter radius:KRadius startAngle:M_PI + increment endAngle:M_PI * 1.5 clockwise:YES];
    CGContextAddPath(_context, path2.CGPath);

    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 addArcWithCenter:KCenter radius:KRadius startAngle:M_PI * 1.5 + increment endAngle:M_PI * 2 clockwise:YES];
    CGContextAddPath(_context, path3.CGPath);
}

- (void)step4{
    [self step3];
    NSLog(@"step4 progress : %f",_progress);
}
- (void)step5{

    [self step2];
    NSLog(@"step5 progress : %f",_progress);
}
- (void)step6{
    [self step1];
    NSLog(@"step6 progress : %f",_progress);
}

- (void)rotateFrom:(id)fromValue to:(id)toValue{

    _rotateAnimaiton = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _rotateAnimaiton.duration = KRotateDuration;
    _rotateAnimaiton.repeatCount = 1;
    _rotateAnimaiton.fromValue = fromValue;
    _rotateAnimaiton.toValue = toValue;
    _rotateAnimaiton.delegate = self;
    [self.layer addAnimation:_rotateAnimaiton forKey:@"rotate"];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"step"]) {
        switch (self.step) {
            case DMLoadingStepOne:
            {
                _progress = 0;
            }
                break;
            case DMLoadingStepTwo:
            {
                _progress = 0;
                [self rotateFrom:0 to:@(M_PI * 2)];
            }
                break;
            case DMLoadingStepThree:
            {
                _progress = 0;
            }
                break;
            case DMLoadingStepFour:
            {
                _progress = 1;
            }
                break;
            case DMLoadingStepFive:
            {
                _progress = 1;
                [self rotateFrom:@(M_PI * 2) to:@(0)];
            }
                break;
            case DMLoadingStepSix:
            {
                _progress = 1;
            }
                break;
        }
    }
}

#pragma mark - AnimaitonDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    if (flag && self.step == DMLoadingStepTwo) {
        _progress = 0;
        self.step = DMLoadingStepThree;
    }
    if (flag && self.step == DMLoadingStepFive) {
        self.step = DMLoadingStepSix;
    }
}
- (void)startAnimaiton{

    [self.layer removeAllAnimations];
    self.step = DMLoadingStepOne;
    _displayLink.paused = NO;
}

- (void)stopAnimation{

    [self.layer removeAllAnimations];
    _displayLink.paused = YES;
    self.step = DMLoadingStepOne;
}
- (void)setLineColor:(UIColor *)color{
    _color = color;
}
@end


