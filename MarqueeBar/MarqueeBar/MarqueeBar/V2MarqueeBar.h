//
//  V2MarqueeBar.h
//  MarqueeBar
//
//  Created by Vols on 15/10/20.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface V2MarqueeBar : UIView

@property (nonatomic, strong) NSString  * title;
@property (nonatomic, strong) UIColor   * tintColor;
@property (nonatomic, strong) UIFont    * titleFont;

+ (instancetype)marqueeBarWithFrame:(CGRect)frame title:(NSString*)title;

- (void)updateTitle:(NSString*)title;

@end
