//
//  V2MarqueeBar.m
//  MarqueeBar
//
//  Created by Vols on 15/10/20.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "V2MarqueeBar.h"

#define SPACE_WIDTH     50
#define LABEL_NUM       2

@interface V2MarqueeBar () {
    
    UILabel     * _firstLabel;
    UILabel     * _secondLabel;
    
    NSTimer     * _timer;
    NSString    * _text;
    UIFont      * _font;

    BOOL        _needFlow;      //是否需要滚动
    
    CGRect      _frame;
    NSInteger   _startIndex;    //当前第一个控件的索引
    CGFloat     _XOffset;       //定时器每次执行偏移后，累计的偏移量之和
    CGSize      _textSize;      //文本显示一行，需要的框架大小
}

@end

@implementation V2MarqueeBar

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        _text       = title;
        _frame      = frame;
        _font       = [UIFont systemFontOfSize:16.0];       //默认的字体大小
        _tintColor  = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];        //默认背景色
        
        _textSize = [self getStringWidth:_text font:_font]; //初始化标签,判断是否需要滚动效果

        if (_textSize.width > frame.size.width) {
            _needFlow = YES;
            [self startRun];
        }
    }
    return self;
}


- (void)setFont:(UIFont *)font {
    _font = font;
    
    [self setNeedsDisplay];
}

- (void)setTitle:(NSString *)title {
    _text = title;
    
    [self setNeedsDisplay];
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    
    [self setNeedsDisplay];
}

//改变一个Rect的起始点位置，但是其终止点的位置不变，因此会导致整个框架大小的变化
- (CGRect)moveNewPoint:(CGPoint)point rect:(CGRect)rect {
    CGSize tmpSize;
    tmpSize.height = rect.size.height + (rect.origin.y - point.y);
    tmpSize.width = rect.size.width + (rect.origin.x - point.x);
    return CGRectMake(point.x, point.y, tmpSize.width, tmpSize.height);
}


- (void)startRun {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}


- (void)cancelRun {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)timerAction {
    static CGFloat offsetOnce = -1;
    _XOffset += offsetOnce;
    if (_XOffset +  _textSize.width <= 0){
        _XOffset += _textSize.width;
        _XOffset += SPACE_WIDTH;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    // Drawing code
    CGFloat startYOffset = (rect.size.height - _textSize.height)/2;
    CGPoint origin = rect.origin;
    if (_needFlow == YES) {
 
        rect = [self moveNewPoint:CGPointMake(_XOffset, startYOffset) rect:rect];
 
        while (rect.origin.x <= rect.size.width+rect.origin.x) {
            NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            NSDictionary*attribute = @{
                                       NSFontAttributeName:_font,
                                       NSParagraphStyleAttributeName:paragraphStyle,
                                       NSForegroundColorAttributeName:_tintColor
                                       };
            [_text drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
            
            rect = [self moveNewPoint:CGPointMake(rect.origin.x+_textSize.width+SPACE_WIDTH, rect.origin.y) rect:rect];
        }
    }
    else {
        //在控件的中间绘制文本
        origin.x = (rect.size.width - _textSize.width)/2;
        origin.y = (rect.size.height - _textSize.height)/2;
        rect.origin = origin;
        
        NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        NSDictionary*attribute = @{
                                   NSFontAttributeName:_font,
                                   NSParagraphStyleAttributeName:paragraphStyle,
                                   NSForegroundColorAttributeName:_tintColor
                                   };
        [_text drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];

    }
}


- (void)dealloc {
    
}


- (CGSize)getStringWidth:(NSString *)string font:(UIFont *)font{
    if (string) {
        CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                           options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:font}
                                           context:nil];
        return rect.size;
    }
    return CGSizeMake(0, 0);
}

@end
