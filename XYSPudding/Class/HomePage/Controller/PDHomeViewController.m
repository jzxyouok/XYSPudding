//
//  PDHomeViewController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDHomeViewController.h"
#import "XYSTitleBar.h"
#import "PDhomeGroupController.h"
#import "PDHomeVideoController.h"
#import "XYSPageController.h"


@interface PDHomeViewController ()

/** 标题栏底层视图 */
@property (nonatomic, strong) UIView *titleView;
/** 标题栏视图 */
@property (nonatomic, strong) XYSTitleBar *titleBar;
/** 分页视图控制器 */
@property (nonatomic, strong) XYSPageController *pageController;
/** 展示的视图控制器存储数组 */
@property (nonatomic, strong) NSArray *viewControllers;

@end

@implementation PDHomeViewController


#pragma mark - getter

/** 标题栏视图 */
- (XYSTitleBar *)titleBar
{
    if (!_titleBar)
    {
        XYSTitleBar *titleBar = [XYSTitleBar barWithTitles:@[@"番组", @"视频"]];
        [titleBar setItemSize:CGSizeMake(170*kScaleW, self.navigationController.navigationBar.height)];
        [titleBar setLineColor:kRGBColor(255, 56, 0)];
        [titleBar setNormalColor:kTextColor];
        [titleBar setSelectedColor:kNaviTextColor];
        [titleBar setShowLine:YES];
        [titleBar setScale:YES];
        [self.navigationController.view  addSubview:titleBar];
        [titleBar mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(0);
             make.centerX.mas_equalTo(0);
             make.width.mas_equalTo(340*kScaleW);
             make.height.mas_equalTo(self.navigationController.navigationBar.height);
         }];
        [titleBar clickHandler:^(NSInteger index)
         {
             NSInteger lastIndex = [_viewControllers indexOfObject:self.pageController.currentViewController];

             XYSPageControllerScrollDirection scrollDirection = XYSPageControllerScrollDirectionLeft;
             if (index < lastIndex)
             {
                 scrollDirection = XYSPageControllerScrollDirectionRight;
             }
             [self.pageController setCurrentViewController:_viewControllers[index]
                                                 direction:scrollDirection
                                                  animated:YES];
         }];
        _titleBar = titleBar;
        
        /** 中线 */
        UIView *middleLine = [UIView new];
        [middleLine setBackgroundColor:kRGBColor(234, 234, 234)];
        [_titleBar addSubview:middleLine];
        [middleLine mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.center.mas_equalTo(0);
             make.height.mas_equalTo(15);
             make.width.mas_equalTo(1);
         }];
    }
    return _titleBar;
}

/** 分页视图控制器 */
- (XYSPageController *)pageController
{
    if(!_pageController)
    {
        _pageController = [XYSPageController pageWithCurrentViewController:_viewControllers[0]
                                                               scrollStyle:0];
        [self addChildViewController:_pageController];
        [self.view addSubview:_pageController.view];
        [_pageController.view mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.edges.mas_equalTo(self.view);
         }];
        
        [_pageController didLoadLeftViewController:^(UIViewController *currentViewController)
        {
            NSInteger index = [_viewControllers indexOfObject:currentViewController];
            if (index<=0)
            {
                [_pageController setLeftViewController:nil];
            }
            else
            {
                [_pageController setLeftViewController:_viewControllers[index-1]];
            }
        }];
        [_pageController didLoadRightViewController:^(UIViewController *currentViewController)
        {
            NSInteger index = [_viewControllers indexOfObject:currentViewController];
            if (index>=_viewControllers.count-1)
            {
                [_pageController setRightViewController:nil];
            }
            else
            {
                [_pageController setRightViewController:_viewControllers[index+1]];
            }
        }];
        [_pageController handlerForDidCompleteScroll:^(UIViewController *currentViewController)
        {
            NSInteger index = [_viewControllers indexOfObject:currentViewController];
            [self.titleBar setSelectedIndex:index];
        }];
    }
    return _pageController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    PDhomeGroupController *groupVC = [[PDhomeGroupController alloc] initWithCollectionViewLayout:flowLayout];
    UIViewController *v2 = [UIViewController new];
    v2.view.backgroundColor = [UIColor redColor];
    _viewControllers = @[groupVC, v2];
    
    [self.navigationItem.titleView setHidden:YES];
    [self.view setBackgroundColor:kBGDColor];
    [self.pageController.view setHidden:NO];
    [self.titleBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
