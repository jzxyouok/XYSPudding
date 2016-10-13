//
//  PDDegGroupsController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupsController.h"
#import "PDShowViewController.h"
#import "UIViewController+NavigationItem.h"
#import "PDDegImageViewModel.h"

@interface PDDegGroupsController ()

@property (nonatomic, strong) PDDegImageViewModel *listViewModel;

@end

@implementation PDDegGroupsController

/** 自定义视图配置的控制器 */
+ (id)defaultController
{
    PDShowViewController *showVC = [PDShowViewController new];
    showVC.viewController = [PDDegGroupsController new];
    
    __block PDShowViewController *blockObj = showVC;
    [showVC.viewController addLeftItemWithStyle:PDLeftItemStyleBackImage
                                   clickHandler:^
     {
         [blockObj viewWillDisappear:YES];
     }];
    [showVC.viewController addRightItemWithStyle:PDRightItemStyleSearchImage
                                    clickHandler:^
     {
         DDLogInfo(@"搜索");
     }];
    
    return showVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"图片"];
    [self.view setBackgroundColor:kBGDColor];
    _listViewModel = [PDDegImageViewModel new];
    [self addRefreshView];
    [self addHeadView];
    [self.tableView setTableFooterView:[UIView new]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 刷新视图 */
- (void)addRefreshView
{
    MJRefreshGifHeader * gifRefreshHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^
                                             {
                                                 [_listViewModel refreshDataWithCompletionHandler:^(NSError *error)
                                                  {
                                                      [self.tableView reloadData];
                                                      [self.tableView.mj_header endRefreshing];
                                                  }];
                                             }];
    [gifRefreshHeader setImages:@[[UIImage imageNamed:@"pudding_anime_1_50x50_"]]
                       forState:MJRefreshStateIdle];
    [gifRefreshHeader setImages:@[[UIImage imageNamed:@"pudding_anime_1_50x50_"], [UIImage imageNamed:@"pudding_anime_2_50x50_"]]
                       duration:0.5
                       forState:MJRefreshStateRefreshing];
    gifRefreshHeader.stateLabel.hidden = YES;
    gifRefreshHeader.labelLeftInset = -95;
    [gifRefreshHeader beginRefreshing];
    self.tableView.mj_header = gifRefreshHeader;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^
                                 {
                                     [_listViewModel getMoreDataWithCompletionHandler:^(NSError *error)
                                      {
                                          [self.tableView reloadData];
                                          [self.tableView.mj_footer endRefreshing];
                                      }];
                                 }];
}

/** 添加头部视图 */
- (void)addHeadView
{
    /** 头部视图 */
    UIView *headView = [UIView viewWithFrame:CGRectMake(0, 0, 0, 40)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableHeaderView:headView];
    /** 图片标签 */
    UIImageView *imageView = [UIImageView viewWithFrame:CGRectMake(10, 0, 28, 28)];
    imageView.positionY = headView.selfCenterY;
    [imageView setImage:[UIImage imageNamed:@"group_icon_recommend_28x28_"]];
    [headView addSubview:imageView];
    /** 文字标签 */
    UILabel *label = [UILabel viewWithFrame:CGRectMake(38, 0, 100, 20)];
    label.positionY = headView.selfCenterY;
    [label setText:@"推荐小组"];
    [label setTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
    [label setFont:[UIFont systemFontOfSize:15]];
    [headView addSubview:label];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    /** 底线视图 */
    UIView *bottomline = [UIView viewWithFrame:CGRectMake(0, 39, headView.width, 1)];
    [bottomline setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]];
    [headView addSubview:bottomline];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _listViewModel.listNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
     if (!cell)
     {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"Cell"];
         [cell setBackgroundColor:[UIColor whiteColor]];
         [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, -10)];
     }
    return cell;
}

@end
