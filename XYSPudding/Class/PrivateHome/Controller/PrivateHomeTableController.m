//
//  PrivateHomeTableController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PrivateHomeTableController.h"
#import "PDLoginButton.h"
#import "PDPrivateHomeCell.h"
#import "PDLoginViewController.h"
#import "PDPrivSetController.h"

@interface PrivateHomeTableController ()
{
    UIView *_headView;
}
@property (nonatomic, strong) NSArray *buttonDatas;

@end

@implementation PrivateHomeTableController

/** 获取cell按钮数据 */
- (NSArray *)buttonDatas
{
    if (!_buttonDatas)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PrivateButtonDatas"
                                                             ofType:@"plist"];
       _buttonDatas = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _buttonDatas;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self defualtConfig];
    [self addHeadView];
    [self addSignInAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 默认参数配置 */
- (void)defualtConfig
{
    [self.tableView setBackgroundColor:kBGDColor];
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

/** 添加头部视图 */
- (void)addHeadView
{
    UIImageView *headView = [UIImageView viewWithFrame:CGRectMake(0, 0, 0, 100*kScale)];
    [self.tableView setTableHeaderView:headView];
    [headView setImage:[UIImage imageNamed:@"mine_list_icon_bg_1024x140_@1x"]];
    [headView setUserInteractionEnabled:YES];
    _headView = headView;
    
    /** 登录按钮 */
    PDLoginButton *loginButton = [PDLoginButton buttonWithType:UIButtonTypeSystem];
    [headView addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(300*kScale);
    }];
    [loginButton bk_addEventHandler:^(id sender)
    {
        PDWindow *loginVCWindow = [PDLoginViewController standardWindowWithController];
        [kKeyWindow addSubview:loginVCWindow.view];

    } forControlEvents:UIControlEventTouchUpInside];
}

/** 签到动画视图配置 */
- (void)addSignInAnimation
{
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"fruit-check-in-1_117x65_"];
    imageView.tag = 10;
    [imageView setUserInteractionEnabled:YES];
    [self.navigationController.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.mas_equalTo(-20*kScale);
        make.bottom.mas_equalTo(-25*kScale-self.tabBarController.tabBar.height);
        make.width.mas_equalTo(117*kScale);
        make.height.mas_equalTo(65*kScale);
    }];
    [imageView bk_whenTapped:^
    {
        PDWindow *loginVCWindow = [PDLoginViewController standardWindowWithController];
        [kKeyWindow addSubview:loginVCWindow.view];
    }];
    [NSTimer bk_scheduledTimerWithTimeInterval:0.5
                                         block:^(NSTimer *timer)
     {
         if (imageView.tag == 10)
         {
             imageView.image = [UIImage imageNamed:@"fruit-check-in-2_117x65_"];
             imageView.tag = 0;
         }
         else
         {
             imageView.image = [UIImage imageNamed:@"fruit-check-in-1_117x65_"];
             imageView.tag = 10;
         }
     } repeats:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.buttonDatas.count;
}

/** 配置cell视图 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 通过复用的方式获取cell */
    PDPrivateHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[PDPrivateHomeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:@"Cell"];
    }
    
    /** 传入数据，设置cell界面 */
    [cell setCellDatas:self.buttonDatas[indexPath.row] clickHandler:^(NSInteger index)
    {
        /** 推出系统设置参数视图 */
        if (indexPath.row == 1 && index == 2)
        {
            PDWindow *setVCWindow = [PDPrivSetController standardWindowWithController];
            [kKeyWindow addSubview:setVCWindow.view];
        }
        else //推出登录界面
        {
            PDWindow *loginVCWindow = [PDLoginViewController standardWindowWithController];
            [kKeyWindow addSubview:loginVCWindow.view];
        }
    }];
    
    /** 为第一个cell添加底线 */
    if (indexPath.row == 0)
    {
        UIView *lineView = [UIView new];
        [lineView setBackgroundColor:kRGBColor(217, 217, 218)];
        [cell addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.bottom.right.mas_equalTo(0);
             make.height.mas_equalTo(1);
         }];
    }
    
    return cell;
}

/** cell高度 */
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150*kScale;
}

@end
