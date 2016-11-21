//
//  ViewController.m
//  MarqueeBar
//
//  Created by Vols on 15/10/20.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "ViewController.h"
#import "VMarqueeBar.h"
#import "V2MarqueeBar.h"
#import "V3MarqueeBar.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"跑马灯";
    

    [self displayUIs];
}

/*
 *  三种方式实现跑马灯效果：
 *      1、UIView的animation动画实现。
 *      2、DrawRect绘制
 *      3、用定时器+Label实现
 */
- (void)displayUIs {

    NSString* text = @"两块钱,你买不了吃亏,两块钱,你买不了上当,真正的物有所值,拿啥啥便宜,买啥啥不贵,都两块,买啥都两块,全场卖两块,随便挑,随便选,都两块！";
    
    VMarqueeBar* marqueeBar = [[VMarqueeBar alloc] initWithFrame:CGRectMake(10, 140, self.view.bounds.size.width-20, 44) title:text];
    marqueeBar.tintColor = [UIColor whiteColor];
    marqueeBar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:marqueeBar];
    
    V2MarqueeBar *marqueeBar2 = [[V2MarqueeBar alloc] initWithFrame:CGRectMake(10, 200, 320, 40) title:text];
    marqueeBar2.tintColor = [UIColor orangeColor];
    [self.view addSubview:marqueeBar2];
    
    V3MarqueeBar *marqueeBar3 = [[V3MarqueeBar alloc] initWithFrame:CGRectMake(10.0, 260.0, 200.0, 30.0) title:text];
    marqueeBar3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:marqueeBar3];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
