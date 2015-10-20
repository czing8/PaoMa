//
//  VAutoScrollLabel.h
//  AutoScrollLabel
//
//  Created by Vols on 15/8/5.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTEXTCOLOR [UIColor redColor]
#define kTEXTFONTSIZE 14

@interface VAutoScrollLabel : UIView

@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, strong) UIFont * textFont;


- (instancetype)initWithFrame:(CGRect)frame text:(NSString*)text;

//SB（Xib）方式 手动调用此方法
- (void)configureViewWithText:(NSString *)text;

- (void)start;//开始跑马

@end
