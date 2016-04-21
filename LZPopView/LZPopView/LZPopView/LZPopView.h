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

@property (strong,nonatomic)UIImage *headerImage;
@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *subTitle;

@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UILabel *subTitleLabel;

@property (copy,nonatomic)LZPopBlock showBlock;
@property (copy,nonatomic)LZPopBlock hidenBlock;
@property (copy,nonatomic)LZPopBlock tapBlock;

//- (instancetype)initWithConfigBlock:(void(^)())configBlock;
- (instancetype)initWithSize:(CGSize)size;
- (void)showInView:(UIView*)view center:(CGPoint)center;
@end
