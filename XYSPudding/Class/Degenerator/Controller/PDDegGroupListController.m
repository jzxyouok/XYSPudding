//
//  PDDegGroupsController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupListController.h"
#import "PDDegGroupViewModel.h"
#import "PDDegGroupListCell.h"

@interface PDDegGroupListController ()

@property (nonatomic, strong) PDDegGroupViewModel *groupViewModel;

@end

@implementation PDDegGroupListController

/** 带导航栏的本控制器视图配置在自定义窗口，返回该窗口对象 */
+ (id)standardWindowWithController
{
    PDWindow *pWindow = [PDWindow standardWindow];
    PDDegGroupListController *groupVC = [PDDegGroupListController new];
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
        __block PDDegGroupListController *blockSelf = self;
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
    UIView *headView = [UIView viewWithFrame:CGRectMake(0, 0, 0, 65*kScale)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableHeaderView:headView];
    /** 图片标签 */
    UIImageView *imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:@"group_icon_recommend_28x28_"]];
    [headView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(28*kScale, 28*kScale));
    }];
    /** 文字标签 */
    UILabel *label = [UILabel new];
    [label setText:@"推荐小组"];
    [label setTextColor:kTextColor];
    [label setFont:[UIFont systemFontOfSize:17*kScale]];
    [headView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(imageView.mas_right).mas_equalTo(10*kScale);
        make.centerY.mas_equalTo(0);
    }];

    /** 底线视图 */
    UIView *bottomline = [UIView new];
    [bottomline setBackgroundColor:kRGBColor(239, 239, 239)];
    [headView addSubview:bottomline];
    [bottomline mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

/** 添加尾部视图 */
- (void)addFootView
{
    /** 尾部视图 */
    UIView *footView = [UIView viewWithFrame:CGRectMake(0, 0, 0, 120*kScale+20)];
    [footView setBackgroundColor:kBGDColor];
    [self.tableView setTableFooterView:footView];
    /** 顶线视图 */
    UIView *topLine = [UIView new];
    [topLine setBackgroundColor:kRGBColor(239, 239, 239)];
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
    [label setBackgroundColor:[UIColor whiteColor]];
    [label setTextColor:kNaviTextColor];
    [label setFont:[UIFont systemFontOfSize:15*kScale]];
    [footView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(1);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50*kScale);
    }];
    [label setUserInteractionEnabled:YES];
    [label bk_whenTapped:^
    {
        /** 推出展示所有小组的表视图 */
        PDDegGroupListController *groupVC = [PDDegGroupListController new];
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
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(label.mas_bottom).mas_equalTo(0);
        make.height.mas_equalTo(70*kScale);
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
    PDDegGroupListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
     if (!cell)
     {
         cell = [[PDDegGroupListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"Cell"];
         [cell setBackgroundColor:[UIColor whiteColor]];
     }
     [cell setDataWithViewModel:_groupViewModel index:indexPath.row];
    return cell;
}

- (CGFloat)   tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80*kScale;
}

/** 取消cell侧边间距 */
kRemoveCellSideSpace

/** 重布局 */
kLayoutView

@end
