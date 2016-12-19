//
//  ViewController.m
//  LZPopView
//
//  Created by Artron_LQQ on 16/4/18.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "ViewController.h"
#import "LZPopView.h"

@interface ViewController ()
{
    LZPopView *pop;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
}

- (IBAction)nomarl:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        pop = [[LZPopView alloc]init];
        
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"10633861_160536558132_2.jpg"]];
        pop.customView = image;
        
        [pop showInView:self.view point:sender.center endBlock:^{
            
        }];
    } else {
        [pop hiddenWithBlock:nil];
    }
}

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
