//
//  VMarqueeBar.h
//  MarqueeBar
//
//  Created by Vols on 15/10/20.
//  Copyright © 2015年 Vols. All rights reserved.
//   

#import <UIKit/UIKit.h>


@interface VMarqueeBar : UIView

@property (nonatomic, strong) NSString  * text;
@property (nonatomic, strong) UIColor   * tintColor;
@property (nonatomic, strong) UIFont    * textFont;


- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;

/*
 *  当用initWithFrame 方式初始化时调用
 */
- (void)configureViewWithTitle:(NSString *)title;

- (void)start;

@end
