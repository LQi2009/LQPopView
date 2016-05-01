//
//  LZPopView.h
//  LZPopView
//
//  Created by Artron_LQQ on 16/4/18.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LZPopAnimationType) {
    LZPopAnimationTypeNone = 0,
    LZPopAnimationTypeFrame,
    LZPopAnimationTypeAlpha,
};

typedef void(^LZPopBlock)();
@interface LZPopView : UIView

@property (strong,nonatomic)UIImage *backgroundImage;
@property (strong,nonatomic)UIImage *headerImage;
@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *subTitle;
@property (assign,nonatomic)CGFloat cornerRadius;

/**
 *  @author LQQ, 16-04-21 16:04:38
 *
 *  间隔,默认10
 */
@property (assign,nonatomic)CGFloat interval;
/**
 *  @author LQQ, 16-04-21 16:04:33
 *
 *  显示时的动画类型,默认LZPopAnimationTypeFrame
 */
@property (assign,nonatomic)LZPopAnimationType showAnimateType;
/**
 *  @author LQQ, 16-04-21 16:04:58
 *
 *  隐藏时的动画类型,默认:LZPopAnimationTypeFrame
 */
@property (assign,nonatomic)LZPopAnimationType hiddenAnimateType;
/**
 *  @author LQQ, 16-04-21 16:04:15
 *
 *  点击视图之后,是否自动隐藏,默认YES
 */
@property (assign,nonatomic)BOOL isTappedAutoHidden;
/**
 *  @author LQQ, 16-04-21 16:04:34
 *
 *  设置背景图片时是否拉伸,使图片不变形,默认YES
 */
@property (assign,nonatomic)BOOL isStretchBackgroundImage;

/**
 *  @author LQQ, 16-04-21 16:04:24
 *
 *  回调block
 */
@property (copy,nonatomic)LZPopBlock showBlock;//出现的时候回调
@property (copy,nonatomic)LZPopBlock hidenBlock;//消失的时候回调
@property (copy,nonatomic)LZPopBlock tapBlock;//点击视图的时候回调
/**
 *  @author LQQ, 16-04-21 16:04:42
 *
 *  初始化视图
 *
 *  @param size 视图的size
 *
 *  @return 返回视图
 */
- (instancetype)initWithSize:(CGSize)size;
/**
 *  @author LQQ, 16-04-21 16:04:04
 *
 *  显示视图
 *
 *  @param view 一般是视图要显示的父视图
 *  @param center 显示在某一点的附近,例如:按钮的中心点
 */
- (void)showInView:(UIView*)view center:(CGPoint)center;
/**
 *  @author LQQ, 16-04-21 16:04:07
 *
 *  隐藏弹出的视图
 */
- (void)hiddenFromeSuperView;
@end
