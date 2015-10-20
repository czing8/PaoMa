//
//  VAutoScrollLabel.m
//  AutoScrollLabel
//
//  Created by Vols on 15/8/5.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VAutoScrollLabel.h"

@implementation VAutoScrollLabel{
    
    CGRect rectMark1;   //标记第一个位置
    CGRect rectMark2;   //标记第二个位置
    
    CGSize labelSize;
    
    NSMutableArray* labelArr;
    
    NSTimeInterval timeInterval;    //时间
}


- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViewWithText:text];
    }
    return self;
}


//SB（Xib）方式 手动调用此方法
- (void)configureViewWithText:(NSString *)text {
    _textColor  = [UIColor redColor];
    _textFont   = [UIFont boldSystemFontOfSize:14];
    _text       = [NSString stringWithFormat:@"  %@  ",text];//间隔
    
    timeInterval = [self displayDurationForString:text];
    
    self.backgroundColor = [UIColor blackColor];
    self.clipsToBounds = YES;
    
    //
    UILabel* textLb = [[UILabel alloc] initWithFrame:CGRectZero];
    textLb.textColor = _textColor;
    textLb.font = _textFont;
    textLb.text = text;
    
    //计算textLb大小
    labelSize = [textLb sizeThatFits:CGSizeZero];
    
    rectMark1 = CGRectMake(0, 0, labelSize.width, self.bounds.size.height);
    rectMark2 = CGRectMake(rectMark1.origin.x+rectMark1.size.width, 0, labelSize.width, self.bounds.size.height);
    
    textLb.frame = rectMark1;
    [self addSubview:textLb];
    
    labelArr = [NSMutableArray arrayWithObject:textLb];
    
    [self start];
}



- (void)startAnimate{
            //
        UILabel* lbindex0 = labelArr[0];
        UILabel* lbindex1 = labelArr[1];
        
        [UIView transitionWithView:self duration:timeInterval options:UIViewAnimationOptionCurveLinear animations:^{
            //
            
            lbindex0.frame = CGRectMake(-rectMark1.size.width, 0, rectMark1.size.width, rectMark1.size.height);
            lbindex1.frame = CGRectMake(lbindex0.frame.origin.x+lbindex0.frame.size.width, 0, lbindex1.frame.size.width, lbindex1.frame.size.height);
            
        } completion:^(BOOL finished) {
            //
            
            lbindex0.frame = rectMark2;
            lbindex1.frame = rectMark1;
            
            [labelArr replaceObjectAtIndex:0 withObject:lbindex1];
            [labelArr replaceObjectAtIndex:1 withObject:lbindex0];
            
            [self startAnimate];
        }];
}


- (void)start{
    
    //判断是否需要reserveTextLb
    BOOL useReserve = labelSize.width > self.bounds.size.width ? YES : NO;
    
    if (useReserve) {
        
        UILabel* reserveTextLb = [[UILabel alloc] initWithFrame:rectMark2];
        reserveTextLb.textColor = _textColor;
        reserveTextLb.font = _textFont;
        reserveTextLb.text = self.text;
        [self addSubview:reserveTextLb];
        
        [labelArr addObject:reserveTextLb];
        
        [self startAnimate];
    }
}


- (NSTimeInterval)displayDurationForString:(NSString*)string {
    
    return string.length/5;
    //    return MIN((float)string.length*0.06 + 0.5, 5.0);
}



- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    
    [labelArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel * label = (UILabel *)obj;
        label.textColor = textColor;
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
