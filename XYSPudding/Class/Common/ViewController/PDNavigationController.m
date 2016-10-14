//
//  PDNavigationController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDNavigationController.h"

@interface PDNavigationController ()

@end

@implementation PDNavigationController

/** 导航栏初始参数设置 */
+ (void)initialize
{
    if (self == [PDNavigationController class])
    {
        UINavigationBar *appearance = [UINavigationBar appearance];
        /* 调整导航栏标题竖向位置 */
        [appearance setTitleVerticalPositionAdjustment:44*(1-kScale)*0.5-2.5
                                         forBarMetrics:UIBarMetricsDefault];
    }
}

/** 导航栏控制器视图的默认配置加载 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:kBGDColor];
    [self.view.layer setCornerRadius:15*kScale];
    [self.view setClipsToBounds:YES];
}

/** 视图出现动画 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /** 设置上移出现动画 */
    self.view.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
    [UIView animateWithDuration:0.5
                     animations:^
     {
         self.view.transform = CGAffineTransformIdentity;
     }];
}

/** 视图消失动画 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    /** 设置下移消失动画 */
    [UIView animateWithDuration:0.5
                     animations:^
     {
         self.view.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
     }];
}

/** 重布局导航栏高度 */
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    /** 调整导航栏高度 */
    self.navigationBar.height = 44*kScale;
}

@end
