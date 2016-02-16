//
//  ViewController.m
//  LoadingTest
//
//  Created by 李国民 on 16/1/15.
//  Copyright © 2016年 李国民. All rights reserved.
//

#import "ViewController.h"
#import "DMLoadingView.h"
@interface ViewController ()
{
    DMLoadingView * layer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, 100, 100);
    btn.center = CGPointMake(self.view.center.x, btn.center.y);
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)btnClicked{

    if (!layer) {
        layer = [[DMLoadingView alloc]init];
    }
    layer.frame = CGRectMake(200, 300, 50, 50);
    layer.center = CGPointMake(self.view.center.x, layer.center.y);
    layer.backgroundColor = [UIColor clearColor];
    [layer setLineColor:[UIColor redColor]];
    [self.view addSubview:layer];
    [layer startAnimaiton];
}

@end
