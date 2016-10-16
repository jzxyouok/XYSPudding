//
//  PDDegTableController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegTableController.h"
#import "PDDegNormalCell.h"
#import "PDDegGroupViewModel.h"
#import "PDDegImageListController.h"
#import "PDDegGroupListController.h"
#import "PDDegGroupTopicListController.h"
#import "PDDegGroupItem.h"

@interface PDDegTableController ()
{
    PDDegGroupViewModel *_groupViewModel;
    /** 展示分组列表的表视图尾部视图 */
    UIView *_footView;
}
@end

@implementation PDDegTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self defaultConfig];
    [self addRefreshView];
}

/** 默认配置 */
- (void)defaultConfig
{
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:kBGDColor];
    /** 头部视图拉开间距 */
    UIView *headView = [UIView viewWithFrame:CGRectMake(0, 0, 0, 30*kScale)];
    [headView setBackgroundColor:kBGDColor];
    [self.tableView setTableHeaderView:headView];
    /** 尾部视图展示部分小组 */
    UIView *footView = [UIView viewWithFrame:CGRectMake(0, 0, 0, 148*kScale)];
    [footView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableFooterView:footView];
    _footView = footView;
    /** 尾部视图的分组标签 */
    PDDegGroupItem *lastView = nil;
    for (int i = 0; i<8; i++)
    {
        PDDegGroupItem *groupItem = [PDDegGroupItem new];
        groupItem.tag = 100+i;
        [footView addSubview:groupItem];
        [groupItem clickHandler:^(NSInteger tag)
         {
             if (_groupViewModel.groupNumber<=0)
             {
                 return ;
             }
              /** 跳转到小组话题列表页面 */
             PDWindow *topicListVCWindow = [PDDegGroupTopicListController
                                            controllerWithBgdImageURL:[_groupViewModel backgroundImageURLWithIndex:tag-100]
                                                                   id:[_groupViewModel groupIDWithIndex:tag-100]
                                                            groupName:[_groupViewModel nameWithIndex:tag-100]];
             [kKeyWindow addSubview:topicListVCWindow.view];
         }];
        
        if (!lastView)
        {
            [groupItem mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.top.mas_equalTo(0);
                 make.size.mas_equalTo(CGSizeMake(kScreenWidth/8, 148*kScale));
             }];
        }
        else
        {
            [groupItem mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.mas_equalTo(lastView.mas_right).mas_equalTo(0);
                 make.top.mas_equalTo(0);
                 make.size.mas_equalTo(lastView);
             }];
        }
        lastView = groupItem;
    }
}

/** 添加上拉刷新视图 */
- (void)addRefreshView
{
    _groupViewModel = [PDDegGroupViewModel defaultGroupViewModel];
    self.tableView.mj_header = [self gifHeaderWithRefreshingBlock:^
    {
        [_groupViewModel refreshDataWithGrupStyle:0
                                CompletionHandler:^(NSError *error)
         {
             [self.tableView reloadData];
             [self didLoadGroupData];
             [self.tableView.mj_header endRefreshing];
         }];
    }];
}

/** 加载尾部视图上的分组数据 */
- (void)didLoadGroupData
{
    NSInteger count = [_groupViewModel groupNumber];
    for (NSInteger i = 0; i < count; i++)
    {
        PDDegGroupItem *groupItem = [_footView viewWithTag:100+i];
        [groupItem setImageURL:[_groupViewModel imageURLWithIndex:i]];
        [groupItem setTitle:[_groupViewModel nameWithIndex:i]];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 通过复用cell获取cell对象 */
    PDDegNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalCell"];
    if (!cell)
    {
        cell = [[PDDegNormalCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"NormalCell"];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        cell.title_ = [self titles][indexPath.row+2];
        cell.imageName_ = [self imageNames][indexPath.row+2];
        cell.describe = @"20个视频";
        
        return cell;
    }
    cell.title_ = [self titles][indexPath.row];
    cell.imageName_ = [self imageNames][indexPath.row];
    cell.describe = @"20个视频";
    
    return cell;
}

/** cell高度 */
- (CGFloat)   tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        return 148*kScale;
    }
    return 47.5*kScale;
}

/** 分组组尾高度设置 */
- (CGFloat)    tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return section == 0 ? 20*kScale : 0;
}

/** 分组尾部视图 */
- (UIView *) tableView:(UITableView *)tableView
viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView viewWithFrame:CGRectZero];
    [view setBackgroundColor:kBGDColor];
    return view;
}

/** cell点击事件 */
- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                                animated:YES];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            /** 跳转到首页的视频页面 */
            self.tabBarController.selectedIndex = 0;
        }
        else
        {
            /** 推出图片主题列表视图 */
            PDWindow *imageListVCWindow = [PDDegImageListController standardWindowWithController];
            [kKeyWindow addSubview:imageListVCWindow.view];
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            /** 推出小组分组列表视图 */
            PDWindow *groupListVCWindow = [PDDegGroupListController standardWindowWithController];
            [kKeyWindow addSubview:groupListVCWindow.view];
        }
    }
}

- (NSArray *)imageNames
{
    return @[@"icon_cyber_space_video_28x28_", @"icon_cyber_space_pic_28x28_", @"icon_cyber_space_group_28x28_"];
}
- (NSArray *)titles
{
    return @[@"视频", @"图片", @"小组"];
}
@end
