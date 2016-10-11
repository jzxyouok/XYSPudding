//
//  PrivateHomeViewController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PrivateHomeViewController.h"

@interface PrivateHomeViewController ()
{
    UIScrollView *_scrollView;
    UIView *_headView;
}

@end

@implementation PrivateHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 添加配置好的滚动视图 */
- (void)addScrollView
{
    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.edges.mas_equalTo(0);
    }];
    _scrollView = scrollView;
}

/** 添加头部视图 */
- (void)addHeadView
{
    UIView *headView = [UIView new];
    [_scrollView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
}
@end
