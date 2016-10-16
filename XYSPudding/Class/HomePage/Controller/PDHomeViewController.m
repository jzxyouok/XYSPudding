//
//  PDHomeViewController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDHomeViewController.h"
#import "XYSTitleBar.h"
#import "ScrollDispalyViewController.h"
#import "PDhomeGroupController.h"
#import "PDHomeVideoController.h"

@interface PDHomeViewController ()<ScrollDispalyViewControllerDelegate>

/** 标题栏底层视图 */
@property (nonatomic, strong) UIView *titleView;
/** 标题栏视图 */
@property (nonatomic, strong) XYSTitleBar *titleBar;
/** 分页滑动视图 */
@property (nonatomic, strong) ScrollDispalyViewController *scrollDisplayVC;
/** 展示的视图控制器存储数组 */
@property (nonatomic, strong) NSArray *viewControllers;
@end

@implementation PDHomeViewController

- (ScrollDispalyViewController *)scrollDisplayVC
{
    if(!_scrollDisplayVC)
    {
        UIViewController *v = [UIViewController new];
        v.view.backgroundColor = [UIColor blueColor];//设置背景色
        UIViewController *v2 = [UIViewController new];
        v2.view.backgroundColor = [UIColor redColor];//设置背景色
        _viewControllers = @[v, v2];

        _scrollDisplayVC = [[ScrollDispalyViewController alloc] initWithControllers:_viewControllers];
        [_scrollDisplayVC setDelegate:self];
        [_scrollDisplayVC setAutoScroll:NO];
        [_scrollDisplayVC setCanCycle:NO];
        [_scrollDisplayVC setShowPageControl:NO];
        [self addChildViewController:_scrollDisplayVC];
        [self.view addSubview:_scrollDisplayVC.view];
        [_scrollDisplayVC.view mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.edges.mas_equalTo(self.view);
         }];
    }
    return _scrollDisplayVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.titleView.hidden = YES;
    [self.view setBackgroundColor:kBGDColor];
//    self.scrollDisplayVC.view.hidden = NO;
    [self addTitleBarView];
}

- (void)scrollDispalyViewController:(ScrollDispalyViewController *)scrollDispalyViewController
                       currentIndex:(NSInteger)index
{
    self.titleBar.selectedItem = index;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 添加标题栏视图 */
- (void)addTitleBarView
{
    UIView *titleView = [UIView new];
    [self.navigationController.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(0);
         make.centerX.mas_equalTo(0);
         make.width.mas_equalTo(340*kScaleW);
         make.height.mas_equalTo(self.navigationController.navigationBar.height);
     }];
    XYSTitleBar *titleBar = [XYSTitleBar barWithTitles:@[@"番组", @"视频"]];
    [titleBar setSize:CGSizeMake(170*kScaleW, self.navigationController.navigationBar.height)];
    [titleBar setLineColor:kRGBColor(255, 56, 0)];
    [titleBar setNormalColor:kTextColor];
    [titleBar setSelectedColor:kNaviTextColor];
    [titleBar setShowLine:YES];
    [titleView addSubview:titleBar];
    [titleBar mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.mas_equalTo(0);
     }];
    [titleBar clickHandler:^(NSInteger index)
    {
//        self.scrollDisplayVC.currentPage = index;

    }];
    _titleBar = titleBar;
    UIView *middleLine = [UIView new];
    [middleLine setBackgroundColor:kRGBColor(234, 234, 234)];
    [titleView addSubview:middleLine];
    [middleLine mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.mas_equalTo(0);
         make.height.mas_equalTo(15);
         make.width.mas_equalTo(1);
     }];
    _titleView = titleView;
}




@end
