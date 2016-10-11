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

/** 初始参数 */
+ (void)initialize
{
    if (self == [PDNavigationController class])
    {
        UINavigationBar *appearance = [UINavigationBar appearance];
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary]; //设置导航栏标签字体属性
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:20];
        attributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
        appearance.titleTextAttributes = attributes;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 视图出现动画 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    
    [UIView animateWithDuration:0.5
                     animations:^
     {
         self.view.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
     }];
}


@end
