//
//  V3MarqueeBar.h
//  MarqueeBar
//
//  Created by Vols on 15/10/20.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface V3MarqueeBar : UIView

@property (nonatomic, strong) NSString  * title;

+ (instancetype)marqueeBarWithFrame:(CGRect)frame title:(NSString*)title;

- (void)updateTitle:(NSString*)title;

- (void)resume;

@end
