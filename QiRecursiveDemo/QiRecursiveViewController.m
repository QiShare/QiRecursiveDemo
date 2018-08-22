//
//  QiRecursiveViewController.m
//  QiRecursiveDemo
//
//  Created by QiShare on 2018/8/22.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiRecursiveViewController.h"

static NSUInteger kCollapseValue = 180000; //!< 崩溃测试值
static NSUInteger kMaxNum = 1000000;    //!< 较大数

@implementation QiRecursiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Fibonacci sequence
    NSUInteger num = [self FibonacciSequenceNum:7];
    NSLog(@"num = %lu",(unsigned long)num);
    
    // 等差数列求和
    NSUInteger sum = [self recursiveSumOfArithmeticPropgressionNum:7];
    NSLog(@"sum= %lu",(unsigned long)sum);
    
    [self setupUI];
}

#pragma mark - Private functions

- (void)setupUI {
    
    self.title = @"递归尾递归";
    NSArray *titleArr = @[@"recursiveNoCollapse",@"recurisiveDebugCollapse",@"recurisiveReleaseCollapse",@"tailRecurisiveNoCollapse",@"tailRecursiveCollapse"];
    
    CGFloat screenW = CGRectGetWidth(self.view.frame);
    CGFloat screenH = CGRectGetHeight(self.view.frame);
    
    CGFloat btnTopMargin = 20.0;
    CGFloat btnW = screenW;
    CGFloat btnH = .0;
    
    if (screenW == 375.0 && screenH == 812.0) {
        btnH = (screenH - 88.0 - 34.0 - btnTopMargin * (titleArr.count - 1)) / titleArr.count;
    } else {
        btnH = (screenH - 64.0) - btnTopMargin * (titleArr.count - 1) / titleArr.count;
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    for (NSInteger i = 0; i < titleArr.count; i++) {
        UIButton *btn = [UIButton new];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(.0, btnH * i + btnTopMargin * (i + 1), btnW, btnH);
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i;
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 斐波那契数列

- (NSUInteger)FibonacciSequenceNum:(NSUInteger)num {
    
    // 0 1 1 2 3 5 8 13
    if (num < 2) {
        return num;
    }
    return [self FibonacciSequenceNum:(num - 1)] + [self FibonacciSequenceNum:(num - 2)];
}

#pragma mark - 递归方式等差数列求和

- (NSUInteger)recursiveSumOfArithmeticPropgressionNum:(NSUInteger)num {

    // 1  2  3  4   5   6   7
    // 1  3  6  10  15  21  28
    if (num < 2) {
        return num;
    }
    return [self recursiveSumOfArithmeticPropgressionNum:(num - 1)] + num;
}

#pragma mark - 尾递归方式等差数列求和

- (NSInteger)tailRecurisveSumOfArithmeticProgressionNum:(NSInteger)num {
    
    return [self tailRecurisveNum:num current:0];
}

- (NSInteger)tailRecurisveNum:(NSInteger)num current:(NSInteger)current {
    
    if (num == 0) {
        return current;
    } else {
        return [self tailRecurisveNum:(num - 1) current: (num + current)];
    }
}

#pragma mark - Action functions

- (void)btnClicked:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
            {
                NSUInteger sum = [self recursiveSumOfArithmeticPropgressionNum:(kCollapseValue - 30000)];
                NSLog(@"sum = %lu",(unsigned long)sum);
                break;
            }
        case 1:
            {
                NSUInteger sum = [self recursiveSumOfArithmeticPropgressionNum:kCollapseValue];
                NSLog(@"sum = %lu",(unsigned long)sum);
                break;
            }
        case 2:
        {
            NSUInteger sum = [self recursiveSumOfArithmeticPropgressionNum:kMaxNum];
            NSLog(@"sum = %lu",(unsigned long)sum);
            break;
        }
        case 3:
            {
                #if DEBUG
                {
                    NSAssert(NO, @"请调整为Release模式");
                    break;
                }
                #endif
                NSUInteger sum = [self tailRecurisveSumOfArithmeticProgressionNum:kMaxNum];
                NSLog(@"sum = %lu",(unsigned long)sum);
                break;
            }
        case 4:
        {
            NSUInteger sum = [self tailRecurisveSumOfArithmeticProgressionNum:kMaxNum];
            NSLog(@"sum = %lu",(unsigned long)sum);
            break;
        }
    }
}
@end
