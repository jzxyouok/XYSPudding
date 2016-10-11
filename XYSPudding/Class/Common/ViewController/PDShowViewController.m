//
//  PDShowViewController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDShowViewController.h"
#import "PDNavigationController.h"

@interface PDShowViewController ()
{
    PDNavigationController *_navigationController;
}
@end

@implementation PDShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (!_viewController)
    {
        return;
    }
    [self addNavigationController];
}

/** 添加配置好的导航栏视图 */
- (void)addNavigationController
{
    _navigationController = [[PDNavigationController alloc] initWithRootViewController:_viewController];
    [self addChildViewController:_navigationController];
    [self.view addSubview:_navigationController.view];
    [_navigationController.view mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(250);
         make.right.mas_equalTo(-250);
         make.top.mas_equalTo(75);
         make.bottom.mas_equalTo(-75);
     }];
}

/** 视图出现透明度动画 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1.0
                     animations:^
    {
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
}
/** 视图消失透明度动画 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_navigationController viewWillDisappear:YES];
    [UIView animateWithDuration:1.0
                     animations:^
     {
         self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
     }
                     completion:^(BOOL finished)
     {
         [self.viewController removeFromParentViewController];
         [self.view removeFromSuperview];
     }];
}


@end
