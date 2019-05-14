# LZPopView

一个自定义的弹出视图,用于展示一段话,或者一段图文详情;视图的弹出带有动画效果,使用方便,并且支持自定义视图;

# 说明

- 视图的样式

这里我设置了四种:

```Objective-C
//显示视图的样式
typedef NS_ENUM(NSInteger,LZPopViewType) {
    LZPopViewTypeValue1 = 0,//显示一个图片,一个标题,一个副标题
    LZPopViewTypeValue2,//显示一个图片,需要设置backgroundImage
    LZPopViewTypeValue3,//显示一段文本,需要设置subTitle
    LZPopViewTypeCustom,//显示一个自定义的view,需要设置customView
};
```

每一种都有说明,有的需要设置对应的属性才有效果;
提供了这个属性来进行设置:

```Objective-C
@property (assign,nonatomic)LZPopViewType popViewType;
```

- 动画的方式

这里的动画方式,目前只加了三种:无动画,由小变大,逐渐显示

```Objective-C
//动画的方式
typedef NS_ENUM(NSInteger,LZPopAnimationType) {
    LZPopAnimationTypeNone = 0,
    LZPopAnimationTypeFrame,
    LZPopAnimationTypeAlpha,
};
```

动画方式的设置我提供了两个属性进行设置,显示时的动画和消失时的动画:

```Objective-C
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
```

视图的界面属性,我提供了下面几个:

```Objective-C
@property (strong,nonatomic)UIImage *backgroundImage;
@property (strong,nonatomic)UIImage *headerImage;
@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *subTitle;
@property (assign,nonatomic)CGFloat cornerRadius;
@property (strong,nonatomic)UIView *customView;
```

用于设置显示的内容;
其他的属性和方法,看demo就能理解;
控件的交互,我是才用`block`形式进行回调的,使用更方便;
添加控件的时候,请不要使用系统的`addSubview`,请使用我提供的添加方法:

```Objective-C
/**
 *  @author LQQ, 16-04-21 16:04:04
 *
 *  显示视图
 *
 *  @param view 一般是视图要显示的父视图
 *  @param center 显示在某一点的附近,例如:按钮的中心点
 *  @param block 回调block
 */
- (void)showInView:(UIView*)view point:(CGPoint)center endBlock:(LZPopBlock)block;
```

视图消失时和被点击时的回调,使用下面两个方法:

```Objective-C
/**
 *  @author LQQ, 16-04-21 16:04:07
 *
 *  隐藏弹出的视图
 *  @param block 回调block
 */
- (void)hiddenWithBlock:(LZPopBlock)block;

/**
 *  @author LQQ, 16-05-19 09:05:01
 *
 *  视图被点击的回调
 *
 *  @param block 回调block
 */
- (void)tapWithBlock:(LZPopBlock)block;
```

# 例子

为便于演示,这里我直接使用了系统的`touchesBegan`方法:

```Objective-C
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static BOOL isOK = YES;
    if (isOK) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        
        pop = [[LZPopView alloc]init];
        
        pop.backgroundImage = [UIImage imageNamed:@"弹框"];
        pop.title = @"流火绯瞳";
        pop.headerImage = [UIImage imageNamed:@"10633861_160536558132_2.jpg"];
        pop.subTitle = @"github地址:https://github.com/LQQZYY/LZPopView,感谢star支持!";
        pop.showAnimateType = LZPopAnimationTypeFrame;
        pop.hiddenAnimateType = LZPopAnimationTypeFrame;

        [pop tapWithBlock:^{
            NSLog(@"视图被点击了");
        }];
        [pop showInView:self.view point:point endBlock:^{
            NSLog(@"视图弹出了");
        }];
    } else {
        [pop hiddenWithBlock:^{
            NSLog(@"视图消失了");
        }];
    }
    
    isOK = !isOK;
}
```

实际使用时,一般是显示在某个按键的附近,传入合适的`center`值即可;

#### 如果对你有帮助,请右上角`Star`或者`Fork`支持一下,感谢!!
##### 如果使用中有bug,请留言,我会第一时间修改
##### 如果有其他的需求或想法,也可以一同讨论
##### [我的博客](http://blog.csdn.net/lqq200912408)
# 效果图

![](https://github.com/LQQZYY/LZPopView/blob/master/qqq.gif)

# (完)
