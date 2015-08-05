//
//  ViewController.m
//  AutoScrollLabel
//
//  Created by Vols on 15/8/5.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "ViewController.h"
#import "VAutoScrollLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
