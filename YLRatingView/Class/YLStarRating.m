//
//  YLStarRating.m
//  StarRatingView
//
//  Created by lin on 2016/10/6.
//  Copyright © 2016年 YangLin. All rights reserved.
//

#import "YLStarRating.h"
#define YL_STAR_NUMBER 5

@interface YLStarRating()
@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;

@end

@implementation YLStarRating

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStar:YL_STAR_NUMBER];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _numberOfStar = YL_STAR_NUMBER;
    [self starInit];
}

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = number;
        [self starInit];
    }
    return self;
}

#pragma mark - 初始化 UI

/**
 前景 和 背景 初始化
 */
- (void)starInit
{
    //初始化默认分数
    _score = _numberOfStar;
    
    if (!_forgroundImage) {
        _forgroundImage = [UIImage imageNamed:@"forground_star"];
    }
    if (!_backgroundImage) {
        _backgroundImage = [UIImage imageNamed:@"background_star"];
    }
    
    self.starBackgroundView = [self addSubViewImage:_backgroundImage];
    self.starForegroundView = [self  addSubViewImage:_forgroundImage];
    [self addSubview:self.starBackgroundView];
    [self addSubview:self.starForegroundView];
}

/**
 添加星星✨

 @param image 添加的星星图片
 @return 返回制定个数 image 的 View
 */
- (UIView *)addSubViewImage:(UIImage *)image
{
    CGRect frame = self.bounds;
    self.clipsToBounds = YES;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    
    for (int i = 0; i < self.numberOfStar; i ++){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height);
        [view addSubview:imageView];
    }
    
    return view;
}

#pragma mark - 点击 view

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isShowOnly == YES) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point)){
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isShowOnly == YES) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf changeStarForegroundViewWithPoint:point];
    }];
}

#pragma mark - 设置分数

- (void)setScore:(CGFloat)score
{
    [self setScore:score withAnimation:YES completion:^(BOOL finished){}];
}

/**
 *  设置控件分数
 *
 *  @param score     分数，必须在 0 － num 之间
 *  @param isAnimate 是否启用动画
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate
{
    [self setScore:score withAnimation:isAnimate completion:^(BOOL finished){}];
}

/**
 *  设置控件分数
 *
 *  @param score      分数，必须在 0 － num 之间
 *  @param isAnimate  是否启用动画
 *  @param completion 动画完成block
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion
{
    score = score/_numberOfStar * 1.0;
    
    if (score < 0){
        score = 0;
    }
    
    if (score > 1){
        score = 1;
    }
    
    CGPoint point = CGPointMake(score * self.frame.size.width, 0);
    
    if(isAnimate){
        __weak __typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:0.2 animations:^{
            [weakSelf changeStarForegroundViewWithPoint:point];
        } completion:^(BOOL finished){
            if (completion){
                completion(finished);
            }
        }];
    } else {
        [self changeStarForegroundViewWithPoint:point];
    }
}

#pragma mark - Change Star Foreground With Point

/**
 *  通过坐标改变前景视图
 *
 *  @param point 坐标
 */
- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0){
        p.x = 0;
    }
    
    if (p.x > self.frame.size.width){
        p.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float score = [str floatValue];
    
    if (_displayStatus == YLStarDisplayStatusComplete) {
        score = ceilf(score*_numberOfStar*1.0)/_numberOfStar;
        
        if (score <= 0) {
            //防止出现0分的问题
            return;
//            score = 1.0/_numberOfStar;
        }
    } else if (_displayStatus == YLStarDisplayStatusHalf){
        if ((score*_numberOfStar - floor(score*_numberOfStar*1.0)) >= 0.5) {
            score = ceil(score*_numberOfStar*1.0)/_numberOfStar;
        } else {
            score = (floorf(score*_numberOfStar*1.0) + 0.5)/_numberOfStar;
        }
    }
    
    //保留小数点后两位
    NSInteger temp = score * self.frame.size.width * 100;
    p.x = temp/100.0;
    
    self.starForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
    _score = score * _numberOfStar;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)]){
        [self.delegate starRatingView:self score:_score];
    }
}


/**
 自动布局 重新设置 view 的 frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!CGRectEqualToRect(self.bounds,self.starBackgroundView.bounds)) {
        _starForegroundView.frame = self.bounds;
        CGRect frame = self.bounds;
        NSInteger i = 0;
        for (UIImageView * imageView in _starForegroundView.subviews) {
            imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height);
            i++;
        }
        _starBackgroundView.frame = self.bounds;
        i =0 ;
        for (UIImageView * imageView in _starBackgroundView.subviews) {
            imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height);
            i++;
        }
    }
}

@end
