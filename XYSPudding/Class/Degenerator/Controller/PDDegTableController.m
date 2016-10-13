//
//  PDDegTableController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegTableController.h"
#import "PDDegNormalCell.h"
#import "PDDegGroupCell.h"
#import "PDDegGroupViewModel.h"
#import "PDDegImageController.h"
#import "PDDegGroupsController.h"

@interface PDDegTableController ()
{
    PDDegGroupViewModel *_groupViewModel;
}
@end

@implementation PDDegTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:kBGDColor];
    
    UIView *headView = [UIView viewWithFrame:CGRectMake(0, 0, 0, 30)];
    [headView setBackgroundColor:kBGDColor];
    [self.tableView setTableHeaderView:headView];
    
    [self addRefreshView];
}

/** 添加上拉刷新视图 */
- (void)addRefreshView
{
    _groupViewModel = [PDDegGroupViewModel new];
    
    MJRefreshGifHeader * gifRefreshHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^
                                             {
                                                 [_groupViewModel refreshDataWithCompletionHandler:^(NSError *error)
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
    gifRefreshHeader.labelLeftInset = -80*kScreenWidth/1024;
    [gifRefreshHeader beginRefreshing];
    self.tableView.mj_header = gifRefreshHeader;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        PDDegGroupCell *cell = [[PDDegGroupCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                     reuseIdentifier:@"GroupCell"];
        [cell setGroupViewModel:_groupViewModel];
        
        return cell;
    }

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

- (CGFloat)   tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        return 130*kScreenWidth/1024.0;
    }
    return 45*kScreenWidth/1024.0;
}

- (CGFloat)    tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return section == 0 ? 15 : 0;
}

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            
        }
        else
        {
            PDDegImageController *imageListVC = [PDDegImageController defaultController];
            [kKeyWindow addSubview:imageListVC.view];
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            PDDegGroupsController *groupVC = [PDDegGroupsController defaultController];
            [kKeyWindow addSubview:groupVC.view];
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
