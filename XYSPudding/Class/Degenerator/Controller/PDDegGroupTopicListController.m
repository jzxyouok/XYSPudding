//
//  PDDegGroupTopicListController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/13.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupTopicListController.h"
#import "PDDegGroupDetailViewModel.h"
#import "PDDegGroupDetailView.h"
#import "PDDegGroupTopicListViewModel.h"
#import "PDDegGroupTopicListCell.h"

@interface PDDegGroupTopicListController ()
{
    /** 记录小组详情视图模型 */
    PDDegGroupDetailViewModel *_groupDetailVM;
    /** 记录小组详情视图对象 */
    PDDegGroupDetailView *_groupDetailView;
    /** 记录小组主题列表模型 */
    PDDegGroupTopicListViewModel *_groupTopicListVM;
}
@end

@implementation PDDegGroupTopicListController

/** 自定义视图配置的控制器 */
+ (id)controllerWithBgdImageURL:(NSURL *)bgdImageURL
                             id:(NSString *)id_
                      groupName:(NSString *)groupName
{
    PDWindow *pWindow = [PDWindow standardWindow];
    PDDegGroupTopicListController *topicListVC = [PDDegGroupTopicListController new];
    topicListVC.bgdImageURL = bgdImageURL;
    topicListVC.id_ = id_;
    topicListVC.groupName = groupName;
    pWindow.rootViewController = topicListVC;
        
    return pWindow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addNavigationItem];
    [self addGroupDetailView];
    
    _groupDetailVM = [[PDDegGroupDetailViewModel alloc] initWithGrupID:_id_];
    _groupTopicListVM = [[PDDegGroupTopicListViewModel alloc] initWithID:_id_];
    [self addRefreshView];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"HeadCell"];
    [self.tableView registerClass:[PDDegGroupTopicListCell class]
           forCellReuseIdentifier:@"ListCell"];
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView setBackgroundColor:kBGDColor];
    [self addWriteTopicView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 导航栏标签 */
- (void)addNavigationItem
{
    /** 为导航栏添加左侧标签 */
    [self addLeftItemWithStyle:PDLeftItemStyleBackImage
                                        clickHandler:^
     {
         [[PDWindow standardWindow] dismiss:YES];
     }];
    /** 为导航栏添加右侧标签 */
    [self addRightItemWithStyle:PDRightItemStyleMoreInfoImage
                   clickHandler:^
    {
                       
    }];
    [self setTitle:_groupName];
}

/** 刷新页面 */
- (void)addRefreshView
{
    self.tableView.mj_header = [self gifHeaderWithRefreshingBlock:^
                                {
                                    /** 刷新小组详情视图数据 */
                                    [_groupDetailVM getDataWithCompletionHandler:^(NSError *error)
                                     {
                                         if (!error)
                                         {
                                             [self loadGroupDetailData];
                                         }
                                     }];
                                    /** 刷新小组主题列表数据 */
                                    [_groupTopicListVM refreshDataWithCompletionHandler:^(NSError *error)
                                     {
                                         if (!error)
                                         {
                                             [self.tableView reloadData];
                                         }
                                         [self.tableView.mj_header endRefreshing];
                                     }];
                                }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^
                                {
                                    /** 加载更多小组主题列表数据 */
                                    [_groupTopicListVM getMoreDataWithCompletionHandler:^(NSError *error)
                                     {
                                         if (!error)
                                         {
                                             [self.tableView reloadData];
                                         }
                                         [self.tableView.mj_footer endRefreshing];
                                     }];
                                }];

}

/** 小组详情视图 */
- (void)addGroupDetailView
{
    PDDegGroupDetailView *groupDetailView = [PDDegGroupDetailView new];
    [groupDetailView setFrame:CGRectMake(0, 0, 0, 240*kScale)];
    _groupDetailView = groupDetailView;
    groupDetailView.hidden = YES;
    [_groupDetailView setImageWithURL:_bgdImageURL];
    [self.tableView setTableHeaderView:groupDetailView];
}

/** 发帖跳转框视图 */
- (void)addWriteTopicView
{
//    UIView *bgdView = [UIView new];
//    [bgdView setBackgroundColor:[UIColor blueColor]];
//    [self.view addSubview:bgdView];
//    [bgdView mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.left.bottom.right.mas_equalTo(0);
//        make.height.mas_equalTo(50);
//    }];
//    
//    /** 头像标签视图 */
//    UIImageView *avatar = [UIImageView new];
//    [avatar setImage:[UIImage imageNamed:@"default_avatar_64x64_"]];
//    [self.view addSubview:avatar];
//    [avatar mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.left.mas_equalTo(13*kScale);
//        make.width.mas_equalTo(CGSizeMake(30*kScale, 30*kScale));
//    }];
//    /** 跳转按钮 */
//    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [presentButton normalTitle:@"么么哒，请尽情发帖吧^ ^"];
//    [bgdView addSubview:presentButton];
//    [presentButton mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.left.mas_equalTo(avatar.mas_right).mas_equalTo(10);
//        make.top.mas_equalTo(10);
//        make.bottom.mas_equalTo(-10);
//        make.right.mas_equalTo(-10);
//    }];
}


/** 加载小组信息 */
- (void)loadGroupDetailData
{
    _groupDetailView.hidden = NO;
    [_groupDetailView setGroupDetailVM:_groupDetailVM];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return _groupTopicListVM.listNumber;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;

    if (indexPath.section == 0)
    {
         cell = [tableView dequeueReusableCellWithIdentifier:@"HeadCell"];
    }
    else
    {
       cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
        [(PDDegGroupTopicListCell *)cell setDataWithViewModel:_groupTopicListVM
                                                        index:indexPath.row];
    }
    
    return cell;
}

//- (CGFloat)   tableView:(UITableView *)tableView
//heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 1)
//    {
//        return 200;
//    }
//    return 10;
//}

- (CGFloat) tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

/** 取消cell侧边距 */
kRemoveCellSideSpace

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

/** 重布局 */
kLayoutView

@end
