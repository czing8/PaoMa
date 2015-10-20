//
//  ViewController.m
//  MarqueeBar
//
//  Created by Vols on 15/10/20.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "ViewController.h"
#import "TextFlowView.h"
#import "VAutoScrollLabel.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [super viewDidLoad];
    TextFlowView *a = [[TextFlowView alloc] initWithFrame:CGRectMake(0, 0, 320, 40) Text:@"wuxuejun123wuxuejun123wuxuejun123wuxuejun123"];
    [self.view addSubview:a];
    
    
    
    NSString* text = @"两块钱,你买不了吃亏,两块钱,你买不了上当,真正的物有所值,拿啥啥便宜,买啥啥不贵,都两块,买啥都两块,全场卖两块,随便挑,随便选,都两块！";
    
    VAutoScrollLabel* label = [[VAutoScrollLabel alloc] initWithFrame:CGRectMake(10, 64, self.view.bounds.size.width-20, 44) text:text];
    label.textColor = [UIColor blueColor];
    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
