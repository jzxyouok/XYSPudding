//
//  PDDegGroupsController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupsController.h"
#import "PDDegGroupViewModel.h"
#import "PDDegGroupsCell.h"

@interface PDDegGroupsController ()

@property (nonatomic, strong) PDDegGroupViewModel *groupViewModel;

@end

@implementation PDDegGroupsController

/** 带导航栏的本控制器视图配置在自定义窗口，返回该窗口对象 */
+ (id)standardWindowWithController
{
    PDWindow *pWindow = [PDWindow standardWindow];
    PDDegGroupsController *groupVC = [PDDegGroupsController new];
    groupVC.style = PDDegGroupStyleNormal;
    pWindow.rootViewController = groupVC;
    
    return pWindow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:kBGDColor];
    _groupViewModel = [PDDegGroupViewModel defaultGroupViewModel];
    [self addRefreshView];
    [self.tableView setTableFooterView:[UIView new]];

    /** 为导航栏添加左侧标签 */
    [self addLeftItemWithStyle:PDLeftItemStyleBackImage
                                        clickHandler:^
     {
         [[PDWindow standardWindow] dismiss:YES];
     }];
    
    if (_style == PDDegGroupStyleNormal)
    {
        [self addHeadView];
        [self setTitle:@"小组"];
    }
    else
    {
        [self setTitle:@"推荐小组"];
        __block PDDegGroupsController *blockSelf = self;
        [self addLeftItemWithStyle:PDLeftItemStyleBackImage
                      clickHandler:^
        {
            [blockSelf.navigationController popViewControllerAnimated:YES];
        }];
        [self addGetMoreDataView];
        [self.tableView setTableFooterView:[UIView new]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 刷新视图 */
- (void)addRefreshView
{
    self.tableView.mj_header = [self gifHeaderWithRefreshingBlock:^
    {
        [_groupViewModel refreshDataWithGrupStyle:(_style+1)
                                CompletionHandler:^(NSError *error)
         {
             if (!error)
             {
                 [self.tableView reloadData];
                 if (_style == PDDegGroupStyleNormal)
                 {
                     [self addFootView];
                 }
             }
             [self.tableView.mj_header endRefreshing];
         }];
    }];
}

/** 获取更多数据视图 */
- (void)addGetMoreDataView
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^
    {
        [_groupViewModel getMoreDataWithCompletionHandler:^(NSError *error)
        {
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }];
    }];
    [footer setRefreshingTitleHidden:YES];
    self.tableView.mj_footer = footer;
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

/** 添加尾部视图 */
- (void)addFootView
{
    /** 尾部视图 */
    UIView *footView = [UIView viewWithFrame:CGRectMake(0, 0, 0, 100)];
    [footView setBackgroundColor:kBGDColor];
    [footView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableFooterView:footView];
    /** 顶线视图 */
    UIView *topLine = [UIView new];
    [topLine setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]];
    [footView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    /** 文字标签 */
    UILabel *label = [UILabel new];
    [label setText:@"查看全部"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[[UIColor orangeColor] colorWithAlphaComponent:0.8]];
    [label setFont:[UIFont systemFontOfSize:15]];
    [footView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(1);
        make.height.mas_equalTo(40);
    }];
    [label setUserInteractionEnabled:YES];
    [label bk_whenTapped:^
    {
        /** 推出展示所有小组的表视图 */
        PDDegGroupsController *groupVC = [PDDegGroupsController new];
        groupVC.style = PDDegGroupStyleAll;
        [self.navigationController pushViewController:groupVC
                                             animated:YES];
    }];
    /** 图片标签 */
    UIImageView *imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:@"loading_logo_145x89_"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setBackgroundColor:kBGDColor];
    [footView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(label.mas_bottom).mas_equalTo(0);
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _groupViewModel.groupNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    PDDegGroupsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
     if (!cell)
     {
         cell = [[PDDegGroupsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"Cell"];
     }
     [cell setDataWithViewModel:_groupViewModel index:indexPath.row];
    return cell;
}

- (CGFloat)   tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*kScreenWidth/1024;
}

/** 重布局 */
kLayoutView

@end
