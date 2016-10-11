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
    UIImageView *headView = [UIImageView viewWithFrame:CGRectMake(0, 0, 0, 100)];
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
        make.width.mas_equalTo(300);
    }];
#warning 按钮高亮状态问题
    [loginButton bk_addEventHandler:^(id sender)
    {
        PDLoginViewController *loginVC = [PDLoginViewController defaultController];
        [kKeyWindow addSubview:loginVC.view];

    } forControlEvents:UIControlEventTouchUpInside];
}

/** 签到动画视图配置 */
- (void)addSignInAnimation
{
    UIImageView *imageView = [UIImageView new];
    [self.navigationController.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(kScreenWidth*0.5-70);
        make.centerY.mas_equalTo(kScreenHeight*0.5-100);
    }];
    imageView.image = [UIImage imageNamed:@"fruit-check-in-1_117x65_"];
    imageView.tag = 10;
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


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDPrivateHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[PDPrivateHomeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:@"Cell"];
        [cell setBackgroundColor:kBGDColor];
        [cell setSelected:NO];
    }
    
    [cell setCellDatas:self.buttonDatas[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

@end
