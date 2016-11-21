//
//  V3MarqueeBar.m
//  MarqueeBar
//
//  Created by Vols on 15/10/20.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "V3MarqueeBar.h"


#define kDefaultSpeed     60.0
#define kDefaultFont      [UIFont systemFontOfSize:15.0]

@interface V3MarqueeBar() {
    NSTimer     * _timer;
}

@property (nonatomic, strong) UILabel *labelOne;
@property (nonatomic, strong) UILabel *labelTwo;
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation V3MarqueeBar

- (NSMutableArray *)labelArray{
    if (!_labelArray) {
        self.labelArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _labelArray;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *raceStr = [NSString stringWithFormat:@"%@    ",title];
        
        [self addSubview:self.labelOne];
        [self addSubview:self.labelTwo];
        _labelOne.text = raceStr;
        _labelTwo.text = raceStr;

        self.labelOne.frame = CGRectMake(0, 0, [self getStringWidth:raceStr], frame.size.height);
        self.labelTwo.frame = CGRectMake(_labelOne.frame.origin.x + _labelOne.bounds.size.width, _labelOne.frame.origin.y, _labelOne.bounds.size.width, _labelOne.bounds.size.height);
        
        [self.labelArray addObject:_labelOne];
        [self.labelArray addObject:_labelTwo];
        _labelTwo.hidden = ![self isNeedRaceAnimate];
    }
    return self;
}

- (void)updateTitle:(NSString *)title{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    NSString *raceStr = [NSString stringWithFormat:@"%@    ",title];
    _labelOne.frame = CGRectMake(0, 0, [self getStringWidth:raceStr], self.bounds.size.height);
    _labelTwo.frame = CGRectMake(_labelOne.frame.origin.x + _labelOne.bounds.size.width, _labelOne.frame.origin.y, _labelOne.bounds.size.width, _labelOne.bounds.size.height);
    _labelOne.text = raceStr;
    _labelTwo.text = raceStr;
    _labelTwo.hidden = ![self isNeedRaceAnimate];
    if ([self isNeedRaceAnimate]) {
        [self startAnimation];
    }
}

- (BOOL)isNeedRaceAnimate{
    return !(_labelOne.bounds.size.width <= self.bounds.size.width);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    if (_labelOne && _labelTwo) {
        _labelOne.frame = CGRectMake(0, 0, _labelOne.bounds.size.width, self.bounds.size.height);
        _labelTwo.frame = CGRectMake(_labelOne.frame.origin.x + _labelOne.bounds.size.width, _labelOne.frame.origin.y, _labelOne.bounds.size.width, _labelOne.bounds.size.height);
    }
    _labelTwo.hidden = ![self isNeedRaceAnimate];
    if ([self isNeedRaceAnimate]) {
        [self startAnimation];
    }
}


- (void)startAnimation{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 / kDefaultSpeed target:self selector:@selector(raceLabelFrameChanged:) userInfo:nil repeats:YES];
    [_timer fire];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)raceLabelFrameChanged:(NSTimer *)timer{
    UILabel *labelOne = [self.labelArray firstObject];
    UILabel *labelTwo = [self.labelArray lastObject];
    CGRect frameOne = labelOne.frame;
    CGRect frameTwo = labelTwo.frame;
    CGFloat firstX = labelOne.frame.origin.x;
    CGFloat secondX = labelTwo.frame.origin.x;
    firstX -= 0.5;
    secondX -= 0.5;
    if (ABS(firstX) >= labelOne.bounds.size.width) {
        firstX = secondX + labelOne.bounds.size.width;
        [self.labelArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
    }
    frameOne.origin.x = firstX;
    frameTwo.origin.x = secondX;
    labelOne.frame = frameOne;
    labelTwo.frame = frameTwo;
}

- (void)resume{
    [self resumeAndStart:NO];
}

- (void)resumeAndStart{
    [self resumeAndStart:YES];
}

- (void)resumeAndStart:(BOOL)start{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _labelOne.frame = CGRectMake(0, 0, _labelOne.bounds.size.width, self.bounds.size.height);
    _labelTwo.frame = CGRectMake(_labelOne.frame.origin.x + _labelOne.bounds.size.width, _labelOne.frame.origin.y, _labelOne.bounds.size.width, _labelOne.bounds.size.height);
    if (start) {
        [self startAnimation];
    }
}



#pragma mark - Properties
- (UILabel *)labelOne {
    if (_labelOne == nil) {
        _labelOne = [[UILabel alloc] init];
        _labelOne.font = kDefaultFont;
        _labelOne.textColor = [UIColor whiteColor];
        _labelOne.textAlignment = NSTextAlignmentCenter;
    }
    return _labelOne;
}

- (UILabel *)labelTwo {
    if (_labelTwo == nil) {
        _labelTwo = [[UILabel alloc] init];
        _labelTwo.font = kDefaultFont;
        _labelTwo.textColor = [UIColor whiteColor];
        _labelTwo.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTwo;
}


- (CGFloat)getStringWidth:(NSString *)string{
    if (string) {
        CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                           options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:kDefaultFont}
                                           context:nil];
        return rect.size.width;
    }
    return 0.f;
}


@end
