//
//  PDDegTableController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegTableController.h"
#import "PDDegNormalCell.h"

@interface PDDegTableController ()

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
    PDDegNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalCell"];
    
    if (!cell)
    {
        cell = [[PDDegNormalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"NormalCell"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cell.title_ = [self titles][indexPath.row+2];
            cell.imageName_ = [self imageNames][indexPath.row+2];
            cell.detailTextLabel.text = @"20个视频";
        }
        
        return cell;
    }
    cell.title_ = [self titles][indexPath.row];
    cell.imageName_ = [self imageNames][indexPath.row];
    cell.detailTextLabel.text = @"20个视频";
    
    return cell;
}

- (CGFloat)    tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return section == 0 ? 15 : 0;
}


- (NSArray *)imageNames
{
    return @[@"icon_cyber_space_video_28x28_", @"icon_cyber_space_pic_28x28_", @"icon_cyber_space_group_28x28_"];
}
- (NSArray *)titles
{
    return @[@"视频", @"小组", @"图片"];
}
@end
