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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static BOOL isOK = YES;
    if (isOK) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        
        pop = [[LZPopView alloc]init];
        
        pop.backgroundImage = [UIImage imageNamed:@"弹框"];
        pop.title = @"aaaaaaaaa";
        pop.headerImage = [UIImage imageNamed:@"10633861_160536558132_2.jpg"];
        pop.subTitle = @"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb";
        pop.showAnimateType = 1;
        pop.hiddenAnimateType = 1;
        
        pop.showBlock = ^(){
            NSLog(@"视图弹出了");
        };
        pop.hidenBlock = ^(){
            NSLog(@"视图消失了");
        };
        pop.tapBlock = ^(){
            NSLog(@"视图被点击了");
        };
        [pop showInView:self.view center:point];
    } else {
        [pop hiddenFromeSuperView];
    }
    
    isOK = !isOK;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
