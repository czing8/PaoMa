//
//  VMarqueeBar.h
//  MarqueeBar
//
//  Created by Vols on 15/10/20.
//  Copyright © 2015年 Vols. All rights reserved.
//   

#import <UIKit/UIKit.h>

/*********************************
 *
 *  支持Storyboard，xib，支持Autolayout 、masonry。手动赋值title属性。
 *
 *********************************/

@interface VMarqueeBar : UIView

@property (nonatomic, strong) NSString  * title;
@property (nonatomic, strong) UIColor   * tintColor;
@property (nonatomic, strong) UIFont    * textFont;

+ (instancetype)marqueeBarWithFrame:(CGRect)frame title:(NSString*)title;

- (void)updateTitle:(NSString*)title;

@end
