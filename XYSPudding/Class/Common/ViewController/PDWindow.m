//
//  PDShowViewController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDWindow.h"
#import "PDNavigationController.h"

@interface PDWindow ()
{
    /** 记录根视图控制器的导航栏对象 */
    PDNavigationController *_navigationController;
}
@end

@implementation PDWindow

/** 多线程单例模式创建窗口对象 */
+ (id)standardWindow
{
    static PDWindow *showVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        showVC = [PDWindow new];
    });
    return showVC;
}

/** 接收传入的根视图控制器 */
- (void)setRootViewController:(UIViewController *)rootViewController
{
    _rootViewController = rootViewController;
    [self addNavigationController];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

/** 为根视图控制器添加导航栏 */
- (void)addNavigationController
{
    _navigationController = [[PDNavigationController alloc] initWithRootViewController:_rootViewController];
    [self addChildViewController:_navigationController];
    [self.view addSubview:_navigationController.view];
    [_navigationController.view mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.mas_equalTo(0);
         make.width.mas_equalTo(540*kScale);
         make.height.mas_equalTo(620*kScale);
     }];
}

/** 视图出现动画 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /** 透明度渐变动画 */
    [UIView animateWithDuration:1.0
                     animations:^
    {
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
}

/** 视图消失动画 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    /** 通知导航栏视图出现消失动画 */
    [_navigationController viewWillDisappear:YES];
    /** 透明度渐变动画 */
    [UIView animateWithDuration:1.0
                     animations:^
     {
         self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
     }
                     completion:^(BOOL finished)
     {
         /** 动画结束，移带有除根视图的导航控制器 */
         [_navigationController removeFromParentViewController];
         [_navigationController.view removeFromSuperview];
         _navigationController.view = nil;
         _navigationController = nil;
         [self.view removeFromSuperview];
     }];
}

/** 释放窗口对象 */
- (void)dismiss:(BOOL)animated
{
    [self viewWillDisappear:animated];
}
@end
