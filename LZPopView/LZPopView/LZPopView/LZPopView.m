//
//  LZPopView.m
//  LZPopView
//
//  Created by Artron_LQQ on 16/4/18.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "LZPopView.h"
#import "Masonry.h"

static CGFloat LZ_width = 200;//弹出视图的最大宽度
@interface LZPopView ()
{
    BOOL _isHasTitle ;
    BOOL _isHasSubTitle;
    BOOL _isHasBackgroundView;
    BOOL _isHasHeaderImage;
    BOOL _isShow;
    
    
    CGSize _superSize;//父视图尺寸
    CGPoint _oppositeCenter;//相对中心点
    CGSize _selfSize;
}

@property (strong,nonatomic)UIImageView *backgroundImageView;
@property (strong,nonatomic)UIImageView *headerImageView;
@end

@implementation LZPopView

- (instancetype)initWithSize:(CGSize)size {
    self = [super init];
    if (self) {
        _selfSize = size;
        [self setUI];
    }
    
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUI];
    }
    
    return self;
}

- (void)setUI {
    UIImageView *backgroundView = [[UIImageView alloc]init];
    [self addSubview:backgroundView];
    self.backgroundImageView = backgroundView;
    
    UIImageView *image = [[UIImageView alloc]init];
    [self addSubview:image];
    self.headerImageView = image;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor grayColor];
    [self  addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *subTitleLabel = [[UILabel alloc]init];
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    subTitleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:subTitleLabel];
    self.subTitleLabel = subTitleLabel;
    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:image attribute:<#(NSLayoutAttribute)#> relatedBy:<#(NSLayoutRelation)#> toItem:<#(nullable id)#> attribute:<#(NSLayoutAttribute)#> multiplier:<#(CGFloat)#> constant:<#(CGFloat)#>]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}



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
    } else {
        [self.headerImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(ws);
            make.bottom.mas_equalTo(ws);
            make.width.mas_equalTo(ws.headerImageView.mas_height);
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

- (void)setHeaderImage:(UIImage *)headerImage {
    _headerImage = headerImage;
    _headerImageView.image = headerImage;
    if (headerImage) {
        _isHasHeaderImage = YES;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
    _isHasTitle = YES;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    _subTitleLabel.text = subTitle;
    _isHasSubTitle = YES;
}

- (void)showInView:(UIView*)view center:(CGPoint)center{
    _superSize = view.frame.size;
    _oppositeCenter = center;
//    _selfSize = CGSizeMake(100, 100);
    _isShow = YES;
    [self beginFrame];
    [self showWithAnimation];
}

- (void)tap:(UITapGestureRecognizer*)tap {
    if (self.tapBlock) {
        self.tapBlock();
    }
    
    [self hiddenWithAnimation];
}

- (void)showWithAnimation {
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionLayoutSubviews animations:^{
        [self endFrame];
    } completion:^(BOOL finished) {
        if (self.showBlock) {
            self.showBlock();
        }
    }];
}

- (void)hiddenWithAnimation {
    _isShow = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionLayoutSubviews animations:^{
//        self.alpha = 0;
        [self beginFrame];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.hidenBlock) {
            self.hidenBlock();
        }
    }];
}
//开始的时候给一次frame,作为动画开始的其实坐标
- (void)beginFrame {
    CGFloat space = 10;
    //添加后的中心点位置,不含大小
    //标注点靠左，在标注点右边弹出
    if (_oppositeCenter.x < 120) {
        //y坐标小于视图一半,在右下方弹出
        if (_oppositeCenter.y < _superSize.height/2.0) {
            self.layer.anchorPoint = CGPointMake(0, 0);
            self.layer.position = CGPointMake(_oppositeCenter.x + space, _oppositeCenter.y);
            //右上方弹出
        }else {
            self.layer.anchorPoint = CGPointMake(0, 1);
            self.layer.position = CGPointMake(_oppositeCenter.x+space, _oppositeCenter.y);
        }
    }else if (_oppositeCenter.x > _superSize.width - 120){     //标注点靠右时，在标注点左边弹出
        
        if (_oppositeCenter.y <_superSize.height/2.0){
            self.layer.anchorPoint = CGPointMake(1, 0);
            self.layer.position = CGPointMake(_oppositeCenter.x - space, _oppositeCenter.y);
        } else {
            self.layer.anchorPoint = CGPointMake(1, 1);
            self.layer.position = CGPointMake(_oppositeCenter.x - space, _oppositeCenter.y);
        }
        
    }else { //否则在标注点正上方或正下方弹出
        
        if (_oppositeCenter.y < _superSize.height/2.0){
            self.layer.anchorPoint = CGPointMake(0.5, 0);
            self.layer.position = CGPointMake(_oppositeCenter.x, _oppositeCenter.y + space);
        } else {
            self.layer.anchorPoint = CGPointMake(0.5, 1);
            self.layer.position = CGPointMake(_oppositeCenter.x, _oppositeCenter.y - space);
        }
    }
    
    self.bounds = CGRectMake(0, 0, 0, 0);
}

- (void)endFrame {
    CGFloat space = 10;
    //弹出视图的真实坐标
    if (_oppositeCenter.x < 120) {   //标注点靠左，在标注点右边弹出
        if (_oppositeCenter.y < _superSize.height/2.0) {
            self.center = CGPointMake(_oppositeCenter.x + space, _oppositeCenter.y);
        }else {
            self.center = CGPointMake(_oppositeCenter.x+space, _oppositeCenter.y);
        }
    }else if (_oppositeCenter.x > _superSize.width - 120){     //标注点靠右时，在标注点左边弹出
        
        if (_oppositeCenter.y <_superSize.height/2.0){
            self.center = CGPointMake(_oppositeCenter.x - space, _oppositeCenter.y);
        } else {
            self.center = CGPointMake(_oppositeCenter.x - space, _oppositeCenter.y - space);
        }
        
    }else { //否则在标注点正上方或正下方弹出
        
        if (_oppositeCenter.y < _superSize.height/2.0){
            self.center = CGPointMake(_oppositeCenter.x , _oppositeCenter.y + space);
        } else {
            self.center = CGPointMake(_oppositeCenter.x , _oppositeCenter.y -space);
        }
    }

    self.bounds = CGRectMake(0, 0 , _selfSize.width, _selfSize.height);
}

/*
- (void)show {
    CGFloat space = 10;
    //添加后的中心点位置,不含大小
    //标注点靠左，在标注点右边弹出
    if (_oppositeCenter.x < 120) {
        //y坐标小于视图一半,在右下方弹出
        if (_oppositeCenter.y < _superSize.height/2.0) {
            self.layer.anchorPoint = CGPointMake(0, 0);
            self.layer.position = CGPointMake(_oppositeCenter.x + space, _oppositeCenter.y);
            //右上方弹出
        }else {
            self.layer.anchorPoint = CGPointMake(0, 1);
            self.layer.position = CGPointMake(_oppositeCenter.x+space, _oppositeCenter.y);
        }
    }else if (_oppositeCenter.x > _superSize.width - 120){     //标注点靠右时，在标注点左边弹出
        
        if (_oppositeCenter.y <_superSize.height/2.0){
            self.layer.anchorPoint = CGPointMake(1, 0);
            self.layer.position = CGPointMake(_oppositeCenter.x - space, _oppositeCenter.y);
        } else {
            self.layer.anchorPoint = CGPointMake(1, 1);
            self.layer.position = CGPointMake(_oppositeCenter.x - space, _oppositeCenter.y);
        }
        
    }else { //否则在标注点正上方或正下方弹出
        
        if (_oppositeCenter.y < _superSize.height/2.0){
            self.layer.anchorPoint = CGPointMake(0.5, 0);
            self.layer.position = CGPointMake(_oppositeCenter.x, _oppositeCenter.y + space);
        } else {
            self.layer.anchorPoint = CGPointMake(0.5, 1);
            self.layer.position = CGPointMake(_oppositeCenter.x, _oppositeCenter.y - space);
        }
    }
    
    //弹出视图的真实坐标
    if (_oppositeCenter.x < _superSize.width - LZ_width - space - 20) {   //标注点靠左，在标注点右边弹出
        if (_oppositeCenter.y < _superSize.height/2.0) {
            [self animationViewInBlock:^{
                self.center = CGPointMake(_oppositeCenter.x + space, _oppositeCenter.y);
                self.bounds = CGRectMake(0, 0 , _selfSize.width, _selfSize.height);
            }];
        }else {
            [self animationViewInBlock:^{
                self.center = CGPointMake(_oppositeCenter.x+space, _oppositeCenter.y);
                self.bounds = CGRectMake(0, 0, _selfSize.width, _selfSize.height);
            }];
        }
    }else if (_oppositeCenter.x > _superSize.width - 120){     //标注点靠右时，在标注点左边弹出
        
        if (_oppositeCenter.y <_superSize.height/2.0){
            [self animationViewInBlock:^{
                self.center = CGPointMake(_oppositeCenter.x  - _selfSize.width - space, _oppositeCenter.y);
                self.bounds = CGRectMake(0, 0 , _selfSize.width, _selfSize.height);
            }];
        } else {
            [self animationViewInBlock:^{
                self.center = CGPointMake(_oppositeCenter.x - _selfSize.width - space, _oppositeCenter.y -_selfSize.height - space);
                self.bounds = CGRectMake(0, 0, _selfSize.width, _selfSize.height);
            }];
        }
        
    }else { //否则在标注点正上方或正下方弹出
        
        if (_oppositeCenter.y < _superSize.height/2.0){
            [self animationViewInBlock:^{
                self.center = CGPointMake(_oppositeCenter.x -_selfSize.width/2, _oppositeCenter.y + space);
                self.bounds = CGRectMake(0, 0, _selfSize.width, _selfSize.height);
            }];
        } else {
            [self animationViewInBlock:^{
                self.center = CGPointMake(_oppositeCenter.x - _selfSize.width/2, _oppositeCenter.y -space -_selfSize.height);
                self.frame = CGRectMake(0, 0, _selfSize.width, _selfSize.height);
            }];
        }
    }
}


//添加动画
- (void)animationViewInBlock:(void(^)())block{
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionLayoutSubviews animations:^{
        if (block) {
            block();
        }
    } completion:^(BOOL finished) {
        
    }];
}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
