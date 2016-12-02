/*!
 @header YLStarRating.h
 
 @abstract 评分或者显示分数的组件，支持绝对布局和自动布局支持 xib
 
 @author 杨林
 
 @version 1.00 2016/10/20 */

#import <UIKit/UIKit.h>

/*!评价*/
@class YLStarRating;

/*!评价代理*/
@protocol YLStarRatingDelegate <NSObject>

@optional

/*!
 代理回调

 @param view 当前对象
 @param score 评分 
 */
-(void)starRatingView:(YLStarRating *)view score:(float)score;

@end

#pragma mark -

typedef NS_ENUM(NSUInteger, YLStarDisplayStatus) {
    YLStarDisplayStatusComplete = 0,    //整数显示（进一）最小1颗星
    YLStarDisplayStatusHalf = 1,        //显示半颗星 最小显示半颗星
    YLStarDisplayStatusInComplete = 2,  //显示为小数 最小为0颗星
};

@interface YLStarRating : UIView


/*! 星星的数量 整数 */
@property (nonatomic, assign) int numberOfStar;

/*! 分数 */
@property (nonatomic,assign) CGFloat score;

/*!
 代理 */
@property (nonatomic, weak) id <YLStarRatingDelegate> delegate;

/*!
 星星的显示状态 是否可现实半个 或者 整个 */
@property (nonatomic) YLStarDisplayStatus displayStatus;

/*! 是否可交互 YES可交互  NO 不可交互,仅展示 默认值为 NO */
@property (nonatomic, assign) BOOL isShowOnly;

/*! 前景图 有默认值 */
@property (nonatomic, strong) UIImage * forgroundImage;
/*! 后景图 有默认值 */
@property (nonatomic, strong) UIImage * backgroundImage;

/*!
 *  Init YLStarRating
 *
 *  @param frame  Rectangles
 *  @param number 星星个数
 *
 *  @return self */
- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number;

/*!
 *  设置控件分数
 *
 *  @param score     分数，必须在 0 － 1 之间
 *  @param isAnimate 是否启用动画 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate;

/*!
 *  设置控件分数
 *
 *  @param score      分数，必须在 0 － 1 之间
 *  @param isAnimate  是否启用动画
 *  @param completion 动画完成block */
- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion;

@end
