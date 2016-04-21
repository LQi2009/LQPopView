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
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static BOOL isOK = YES;
    if (isOK) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        
        pop = [[LZPopView alloc]initWithSize:CGSizeMake(200, 60)];
        pop.backgroundColor = [UIColor greenColor];
        pop.title = @"aaa";
        //    pop.backgroundImageView.image = [UIImage new];
        pop.title = @"aaaaaaaaa";
        pop.headerImage = [UIImage imageNamed:@"10633861_160536558132_2.jpg"];
        pop.subTitle = @"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb";
        
        [self.view addSubview:pop];
        [pop showInView:self.view center:point];
    }
    
    isOK = !isOK;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
