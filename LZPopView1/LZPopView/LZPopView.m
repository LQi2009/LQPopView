//
//  LZPopView.m
//  LZPopView
//
//  Created by Artron_LQQ on 16/4/18.
//  Copyright © 2016年 Artup. All rights reserved.
//
/**
 *  @author LQQ, 16-04-21 16:04:39
 *
 *  blog:http://blog.csdn.net/lqq200912408
    https://github.com/LQQZYY/LZPopView
 *  QQ:302934443
 *
 */
/*sy.luo 4.25 修改*/
#import "LZPopView.h"

@interface LZPopView ()
{
    CGSize _superSize;//父视图尺寸
    
    CGSize _selfSize;//自身大小
    
    LZPopBlock showBlock;
    LZPopBlock hidenBlock;
    LZPopBlock tapBlock;
}

@property (strong,nonatomic)UIImageView *backgroundImageView;
@property (strong,nonatomic)UIImageView *headerImageView;
@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UILabel *subTitleLabel;
@end

@implementation LZPopView

- (instancetype)initWithSize:(CGSize)size {
    self = [super init];
    if (self) {
        _selfSize = size;
        [self setUI];
        [self addGesture];
        
        _showAnimateType = LZPopAnimationTypeFrame;
        _hiddenAnimateType = LZPopAnimationTypeFrame;
        _isTappedAutoHidden = YES;
        _isStretchBackgroundImage = YES;
        _interval = 10.0;
        
        [self setPopViewType:LZPopViewTypeValue1];
    }
    
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        
        _showAnimateType = LZPopAnimationTypeFrame;
        _hiddenAnimateType = LZPopAnimationTypeFrame;
        _isTappedAutoHidden = YES;
        _isStretchBackgroundImage = YES;
        _selfSize = CGSizeMake(200, 80);
        _interval = 10.0;
        
        [self setUI];
        [self addGesture];
        
        [self setPopViewType:LZPopViewTypeValue1];
    }
    
    return self;
}

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    self.bounds = CGRectMake(0, 0, _selfSize.width, _selfSize.height);
    UIImageView *backgroundView = [[UIImageView alloc]init];
    [self addSubview:backgroundView];
    self.backgroundImageView = backgroundView;
//    backgroundView.backgroundColor = [UIColor redColor];
    
    UIImageView *image = [[UIImageView alloc]init];
    [self addSubview:image];
    self.headerImageView = image;
//    image.backgroundColor = [UIColor orangeColor];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor grayColor];
    [self  addSubview:titleLabel];
    self.titleLabel = titleLabel;
//    titleLabel.backgroundColor = [UIColor cyanColor];
    
    UILabel *subTitleLabel = [[UILabel alloc]init];
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    subTitleLabel.textColor = [UIColor lightGrayColor];
    subTitleLabel.numberOfLines = 0;
    [self addSubview:subTitleLabel];
    self.subTitleLabel = subTitleLabel;
<<<<<<< HEAD:LZPopView1/LZPopView/LZPopView.m
<<<<<<< HEAD:LZPopView/LZPopView副本/LZPopView/LZPopView.m
    
    
}
//********** 下面的界面布局,可根据自己的需求调整 **************
- (void)layoutSubviews {
    __weak typeof(self)ws = self;
    if (_isShow) {
        
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(ws);
        }];
        
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(ws).offset(10);
            make.bottom.mas_equalTo(ws).offset(-10);
            make.width.mas_equalTo(ws.headerImageView.mas_height);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.headerImageView.mas_right).offset(10);
            make.right.mas_equalTo(ws).offset(-10);
            make.top.mas_equalTo(ws).offset(10);
            make.height.mas_equalTo(ws.subTitleLabel);
            make.bottom.mas_equalTo(ws.subTitleLabel.mas_top);
        }];
        
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.titleLabel.mas_bottom);
            make.left.right.and.height.mas_equalTo(ws.titleLabel);
            make.bottom.mas_equalTo(ws).offset(-10);
        }];
        //收回的时候含有偏移量的约束需要重新设置,
        //因为self的size设置为(0,0),含有偏移量会输出约束冲突

    } else {
        [self.headerImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(ws);
            make.bottom.mas_equalTo(ws);
        }];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ws.headerImageView.mas_right);
            make.right.mas_equalTo(ws);
            make.top.mas_equalTo(ws);
            make.height.mas_equalTo(ws.subTitleLabel);
            make.bottom.mas_equalTo(ws.subTitleLabel.mas_top);
        }];
        
        [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.titleLabel.mas_bottom);
            make.left.right.and.height.mas_equalTo(ws.titleLabel);
            make.bottom.mas_equalTo(ws);
        }];
    }
}
=======
//    subTitleLabel.backgroundColor = [UIColor yellowColor];
    
}
=======
//    subTitleLabel.backgroundColor = [UIColor yellowColor];
    
}
>>>>>>> LQQZYY/master:LZPopView1/LZPopView/LZPopView.m

//- (void)layoutSubviews {
//}

<<<<<<< HEAD:LZPopView1/LZPopView/LZPopView.m
>>>>>>> LQQZYY/master:LZPopView1/LZPopView/LZPopView.m
=======
>>>>>>> LQQZYY/master:LZPopView1/LZPopView/LZPopView.m
#pragma mark - 重写setter
- (void)setBackgroundImage:(UIImage *)backgroundImage {
    UIImage *newImage = nil;
    if (self.isStretchBackgroundImage) {
      newImage = [backgroundImage stretchableImageWithLeftCapWidth:backgroundImage.size.width/2.0 topCapHeight:backgroundImage.size.height/2.0];
    } else {
        newImage = backgroundImage;
    }
    
    _backgroundImage = newImage;
    _backgroundImageView.image = newImage;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setHeaderImage:(UIImage *)headerImage {
    _headerImage = headerImage;
    _headerImageView.image = headerImage;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    _subTitleLabel.text = subTitle;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
- (void)setCustomView:(UIView *)customView {
    if (customView) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        [self addSubview:customView];
        customView.frame = self.bounds;
        
        _customView = customView;
    }
}

- (void)setPopViewType:(LZPopViewType)popViewType {

    switch (popViewType) {
        case LZPopViewTypeValue1:{
            self.backgroundImageView.frame = self.bounds;
            self.headerImageView.frame = CGRectMake(10, 10, _selfSize.height - 20, _selfSize.height - 20);
            self.titleLabel.frame = CGRectMake(self.headerImageView.bounds.size.width + 20, 10, _selfSize.width - (self.headerImageView.bounds.size.width + 30), 20/80.0 * _selfSize.height);
            self.subTitleLabel.frame = CGRectMake(self.headerImageView.bounds.size.width + 20, self.titleLabel.bounds.origin.y + self.titleLabel.bounds.size.height + 16, self.titleLabel.bounds.size.width, _selfSize.height - (26 + self.titleLabel.bounds.size.height));
        }
            break;
        case LZPopViewTypeValue2:{
            [self.titleLabel removeFromSuperview];
            [self.subTitleLabel removeFromSuperview];
            [self.headerImageView removeFromSuperview];
            self.backgroundImageView.frame = CGRectMake(10, 10, _selfSize.width - 20, _selfSize.height - 20);
        }
            break;
        case LZPopViewTypeValue3:{
            [self.titleLabel removeFromSuperview];
            [self.headerImageView removeFromSuperview];
            self.subTitleLabel.frame = CGRectMake(10, 10, _selfSize.width - 20, _selfSize.height - 20);
        }
            break;
        case LZPopViewTypeCustom:{
            [self.subTitleLabel removeFromSuperview];
            [self.headerImageView removeFromSuperview];
            [self.backgroundImageView removeFromSuperview];
            [self.titleLabel removeFromSuperview];
        }
            break;
        default:
            break;
    }
    
    _popViewType = popViewType;
}

//********** end **************
////********** 下面的可不用修改 **************
#pragma mark - 添加点击手势
- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

#pragma mark - public method
- (void)showInView:(UIView*)view point:(CGPoint)center endBlock:(LZPopBlock)block {
    
    showBlock = block;
    _superSize = view.frame.size;
    [view addSubview:self];
    
    [self setupSelfCenter:center];
    
    switch (self.showAnimateType) {
        case LZPopAnimationTypeNone: {
            
            break;
        }
        case LZPopAnimationTypeFrame: {
            self.transform = CGAffineTransformMakeScale(0, 0);
            break;
        }
        case LZPopAnimationTypeAlpha: {
            self.alpha = 0;
            break;
        }
        default:
            break;
    }
    
    [self showWithAnimation];
}

- (void)hiddenWithBlock:(LZPopBlock)block {
    hidenBlock = block;
    [self hiddenWithAnimation];
}

- (void)tapWithBlock:(LZPopBlock)block {
    tapBlock = block;
}
#pragma mark - private method
- (void)tap:(UITapGestureRecognizer*)tap {
    if (tapBlock) {
        tapBlock();
    }
    
    if (self.isTappedAutoHidden) {
        [self removeFromSuperview];
    }
}

- (void)showWithAnimation {
    [self animationWithInterval:0.6 beginBlock:^{
        switch (self.showAnimateType) {
            case LZPopAnimationTypeNone: {
                self.hidden = NO;
                break;
            }
            case LZPopAnimationTypeFrame: {
                self.transform = CGAffineTransformMakeScale(1, 1);
                break;
            }
            case LZPopAnimationTypeAlpha: {
                self.alpha = 1;
                break;
            }
            default:
                break;
        }
    } endBlock:^{
        if (showBlock) {
            showBlock();
        }
    }];
}

- (void)hiddenWithAnimation {
    
<<<<<<< HEAD:LZPopView1/LZPopView/LZPopView.m
<<<<<<< HEAD:LZPopView/LZPopView副本/LZPopView/LZPopView.m
    _isShow = (self.hiddenAnimateType == LZPopAnimationTypeAlpha);
//    [self layoutSubviews];
    _titleLabel.text = @"";
    _subTitleLabel.text = @"";
=======
=======
>>>>>>> LQQZYY/master:LZPopView1/LZPopView/LZPopView.m
//    [self layoutSubviews];
    
>>>>>>> LQQZYY/master:LZPopView1/LZPopView/LZPopView.m
    [self animationWithInterval:0.4 beginBlock:^{
        switch (self.hiddenAnimateType) {
            case LZPopAnimationTypeNone: {
                self.hidden = YES;
                break;
            }
            case LZPopAnimationTypeFrame: {
                self.transform = CGAffineTransformMakeScale(0, 0);
                break;
            }
            case LZPopAnimationTypeAlpha: {
                self.alpha = 0;
                break;
            }
            default:
                break;
        }
    } endBlock:^{
        [self removeFromSuperview];
        if (hidenBlock) {
            hidenBlock();
        }
    }];
}

- (void)animationWithInterval:(NSTimeInterval)interval beginBlock:(void(^)())beginBlock endBlock:(void(^)())endBlock{
//    usingSpringWithDamping 的范围为 0.0f 到 1.0f ，数值越小「弹簧」的振动效果越明显。
//    initialSpringVelocity 则表示初始的速度，数值越大一开始移动越快。
    [UIView animateWithDuration:interval delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionLayoutSubviews animations:^{

        if (beginBlock) {
            beginBlock();
        }
    } completion:^(BOOL finished) {
        if (endBlock) {
            endBlock();
        }
    }];

}

//设置frame
- (void)setupSelfCenter:(CGPoint)center {
    
    //标注点靠左，在标注点右边弹出
    if (center.x < 120) {
        //y坐标小于视图一半,在右下方弹出
        if (center.y < _superSize.height/2.0) {
            self.layer.anchorPoint = CGPointMake(0, 0);
            self.layer.position = CGPointMake(center.x + self.interval, center.y);
            //右上方弹出
        }else {
            self.layer.anchorPoint = CGPointMake(0, 1);
            self.layer.position = CGPointMake(center.x+self.interval, center.y);
        }
    }else if (center.x > _superSize.width - 120){     //标注点靠右时，在标注点左边弹出
        
        if (center.y <_superSize.height/2.0){
            self.layer.anchorPoint = CGPointMake(1, 0);
            self.layer.position = CGPointMake(center.x - self.interval, center.y);
        } else {
            self.layer.anchorPoint = CGPointMake(1, 1);
            self.layer.position = CGPointMake(center.x - self.interval, center.y);
        }
        
    }else { //否则在标注点正上方或正下方弹出
        
        if (center.y < _superSize.height/2.0){
            self.layer.anchorPoint = CGPointMake(0.5, 0);
            self.layer.position = CGPointMake(center.x, center.y + self.interval);
        } else {
            self.layer.anchorPoint = CGPointMake(0.5, 1);
            self.layer.position = CGPointMake(center.x, center.y - self.interval);
        }
    }
}

<<<<<<< HEAD:LZPopView1/LZPopView/LZPopView.m
<<<<<<< HEAD:LZPopView/LZPopView副本/LZPopView/LZPopView.m
=======
=======
>>>>>>> LQQZYY/master:LZPopView1/LZPopView/LZPopView.m
- (void)dealloc {
    NSLog(@"dealloc");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
>>>>>>> LQQZYY/master:LZPopView1/LZPopView/LZPopView.m

@end
