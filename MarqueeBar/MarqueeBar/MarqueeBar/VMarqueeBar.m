//
//  VMarqueeBar.m
//  MarqueeBar
//
//  Created by Vols on 15/10/20.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "VMarqueeBar.h"

#define kTextColor      [UIColor redColor]
#define kTextFontSize   15

@interface VMarqueeBar () {
    
    CGRect rectMark1;   //标记第一个位置
    CGRect rectMark2;   //标记第二个位置

    CGSize labelSize;
    
    NSMutableArray* labelArr;
    
    NSTimeInterval timeInterval;    //时间
}

@end


@implementation VMarqueeBar

#pragma mark - LifeCycle

+ (instancetype)marqueeBarWithFrame:(CGRect)frame title:(NSString*)title {
    VMarqueeBar * marqueeBar = [[VMarqueeBar alloc] initWithFrame:frame];
    marqueeBar.title = title;
    return marqueeBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initStatus];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initStatus];
    }
    return self;
}


/*
 *  默认设置
 */
- (void)initStatus {
    _tintColor  = [UIColor redColor];               //默认颜色
    _textFont   = [UIFont systemFontOfSize:15];     //默认文字大小
    self.backgroundColor    = [UIColor blackColor];
    self.clipsToBounds      = YES;
}


- (void)updateTitle:(NSString *)title {
    self.title = title;
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _title          = [NSString stringWithFormat:@"  %@  ",title];//间隔
    timeInterval    = [self displayDurationForString:title];
    
    UILabel * textLb = [[UILabel alloc] initWithFrame:CGRectZero];
    textLb.textColor = _tintColor;
    textLb.font = _textFont;
    textLb.text = title;
    
    labelSize = [textLb sizeThatFits:CGSizeZero];
    
    rectMark1 = CGRectMake(0, 0, labelSize.width + 20, self.bounds.size.height);
    rectMark2 = CGRectMake(rectMark1.size.width, 0, rectMark1.size.width, rectMark1.size.height);
    
    textLb.frame = rectMark1;
    [self addSubview:textLb];
    
    labelArr = [NSMutableArray arrayWithObject:textLb];
    
    [self start];
}


- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    
    [labelArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel * label = (UILabel *)obj;
        label.textColor = tintColor;
    }];
}


- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;

    [labelArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel * label = (UILabel *)obj;
        label.font = textFont;
    }];
}


#pragma mark - Animation

- (void)startAnimate{

    UILabel* lbindex0 = labelArr[0];
    UILabel* lbindex1 = labelArr[1];
    
    [UIView transitionWithView:self duration:timeInterval options:UIViewAnimationOptionCurveLinear animations:^{
        
        lbindex0.frame = CGRectMake(-rectMark1.size.width-150, 0, rectMark1.size.width, rectMark1.size.height);
        lbindex1.frame = CGRectMake(0, 0, rectMark2.size.width, rectMark2.size.height);
        
    } completion:^(BOOL finished) {
        
        lbindex0.frame = rectMark2;
        lbindex1.frame = rectMark1;
        
        [labelArr replaceObjectAtIndex:0 withObject:lbindex1];
        [labelArr replaceObjectAtIndex:1 withObject:lbindex0];
        [self startAnimate];
    }];
}

- (void)start {

    //判断是否需要reserveTextLb
    BOOL useReserve = labelSize.width > self.bounds.size.width ? YES : NO;
    
    if (useReserve) {
        
        UILabel* reserveTextLb = [[UILabel alloc] initWithFrame:rectMark2];
        reserveTextLb.textColor = _tintColor;
        reserveTextLb.font = _textFont;
        reserveTextLb.text = self.title;
        [self addSubview:reserveTextLb];
        
        [labelArr addObject:reserveTextLb];
        
        [self startAnimate];
    }
}


- (NSTimeInterval)displayDurationForString:(NSString*)string {
    return string.length/2.f;
}



@end
