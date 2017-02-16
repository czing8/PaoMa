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

@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation V3MarqueeBar

+ (instancetype)marqueeBarWithFrame:(CGRect)frame title:(NSString*)title {
    V3MarqueeBar * marqueeBar = [[V3MarqueeBar alloc] initWithFrame:frame];
    marqueeBar.title = title;
    return marqueeBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.firstLabel];
        [self addSubview:self.secondLabel];
        
        [self.labelArray addObject:_firstLabel];
        [self.labelArray addObject:_secondLabel];
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }

    NSString *raceStr = [NSString stringWithFormat:@"%@    ",title];
    _firstLabel.text = raceStr;
    _secondLabel.text = raceStr;
    
    self.firstLabel.frame = CGRectMake(0, 0, [self getStringWidth:raceStr], self.frame.size.height);
    self.secondLabel.frame = CGRectMake(_firstLabel.frame.origin.x + _firstLabel.bounds.size.width, _firstLabel.frame.origin.y, _firstLabel.bounds.size.width, _firstLabel.bounds.size.height);
    
    _secondLabel.hidden = ![self isNeedRaceAnimate];
    
    if ([self isNeedRaceAnimate]) {
        [self startAnimation];
    }
}

- (void)updateTitle:(NSString *)title {
    self.title = title;
}

- (BOOL)isNeedRaceAnimate{
    return !(_firstLabel.bounds.size.width <= self.bounds.size.width);
}

- (void)layoutSubviews{
    [super layoutSubviews];

    if (_firstLabel && _secondLabel) {
        _firstLabel.frame = CGRectMake(0, 0, _firstLabel.bounds.size.width, self.bounds.size.height);
        _secondLabel.frame = CGRectMake(_firstLabel.frame.origin.x + _firstLabel.bounds.size.width, _firstLabel.frame.origin.y, _firstLabel.bounds.size.width, _firstLabel.bounds.size.height);
    }
    _secondLabel.hidden = ![self isNeedRaceAnimate];
}


- (void)startAnimation{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 / kDefaultSpeed target:self selector:@selector(raceLabelFrameChanged:) userInfo:nil repeats:YES];
    [_timer fire];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)raceLabelFrameChanged:(NSTimer *)timer{
    UILabel *firstLabel = [self.labelArray firstObject];
    UILabel *secondLabel = [self.labelArray lastObject];
    CGRect frameOne = firstLabel.frame;
    CGRect frameTwo = secondLabel.frame;
    CGFloat firstX = firstLabel.frame.origin.x;
    CGFloat secondX = secondLabel.frame.origin.x;
    firstX -= 0.5;
    secondX -= 0.5;
    if (ABS(firstX) >= firstLabel.bounds.size.width) {
        firstX = secondX + firstLabel.bounds.size.width;
        [self.labelArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
    }
    frameOne.origin.x = firstX;
    frameTwo.origin.x = secondX;
    firstLabel.frame = frameOne;
    secondLabel.frame = frameTwo;
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
    _firstLabel.frame = CGRectMake(0, 0, _firstLabel.bounds.size.width, self.bounds.size.height);
    _secondLabel.frame = CGRectMake(_firstLabel.frame.origin.x + _firstLabel.bounds.size.width, _firstLabel.frame.origin.y, _firstLabel.bounds.size.width, _firstLabel.bounds.size.height);
    if (start) {
        [self startAnimation];
    }
}



#pragma mark - Properties
- (UILabel *)firstLabel {
    if (_firstLabel == nil) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.font = kDefaultFont;
        _firstLabel.textColor = [UIColor whiteColor];
        _firstLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _firstLabel;
}

- (UILabel *)secondLabel {
    if (_secondLabel == nil) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.font = kDefaultFont;
        _secondLabel.textColor = [UIColor whiteColor];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _secondLabel;
}

- (NSMutableArray *)labelArray{
    if (!_labelArray) {
        self.labelArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _labelArray;
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
