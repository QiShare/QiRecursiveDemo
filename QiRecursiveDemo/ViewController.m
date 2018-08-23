//
//  ViewController.m
//  QiRecursiveDemo
//
//  Created by QiShare on 2018/8/22.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *btn1 = [self createButtonWithTitle:@"尾调用优化" andFrame:CGRectMake(110.0, 200.0, 150.0, 150.0)];
    [self.view addSubview:btn1];
    UIButton *btn2 = [self createButtonWithTitle:@"无尾调用优化" andFrame:CGRectMake(110.0, 400.0, 150.0, 150.0)];
    [self.view addSubview:btn2];
}

// OC尾调用优化：
- (NSInteger)func1:(NSInteger)num {

    if (num >= 2000000) {
        return num;
    }

    return [self func1:(num + 1)];// 尾调用优化：栈帧可以复用，一直使用同一块栈内存。
}


// 无尾调用优化：
- (NSInteger)func2:(NSInteger)num {

    if (num >= 2000000) {
        return num;
    }
    
    return [self func2:(num + 1)] + .0;// 无尾调用优化：后面追加了个0.0，不符合尾调用优化条件！所以一直在进栈，直至栈溢出崩溃。
}

// 点击事件
- (void)btnClicked:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"尾调用优化"]) {
        [self func1:0];
    }
    else if ([sender.titleLabel.text isEqualToString:@"无尾调用优化"]) {
        [self func2:0];
    }
    
    NSLog(@"Success：------------- QiShare提醒您：能走到这里，说明没有栈溢出");
}

// 创建Button
- (UIButton *)createButtonWithTitle:(NSString *)title andFrame:(CGRect)frame {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.backgroundColor = [UIColor lightGrayColor];
    button.titleLabel.font = [UIFont systemFontOfSize:22.0];
    button.layer.cornerRadius = frame.size.height / 2.0;
    button.layer.masksToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end
