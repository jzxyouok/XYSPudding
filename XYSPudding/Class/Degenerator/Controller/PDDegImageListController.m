//
//  PDDegImageController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegImageListController.h"
#import "PSCollectionView.h"
#import "PDDegImageListViewModel.h"
#import "PDImageListCell.h"

@interface PDDegImageListController ()<UIScrollViewDelegate, PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, strong) PDDegImageListViewModel *imagelistVM;

@end

@implementation PDDegImageListController

/** 带导航栏的本控制器视图配置在自定义窗口，返回该窗口对象 */
+ (id)standardWindowWithController
{
    PDWindow *pWindow = [PDWindow standardWindow];
    pWindow.rootViewController = [PDDegImageListController new];
    return pWindow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"图片"];
    [self.view setBackgroundColor:kBGDColor];
    [self addNavigationItems];
    
    _imagelistVM = [PDDegImageListViewModel new];
    [self addCollectionView];
    [self addRefreshView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 导航栏标签 */
- (void)addNavigationItems
{
    /** 为导航栏添加侧标签 */
    [self addLeftItemWithStyle:PDLeftItemStyleBackImage
                                        clickHandler:^
     {
         [[PDWindow standardWindow] dismiss:YES];
     }];
    [self addRightItemWithStyle:PDRightItemStyleSearchImage
                                         clickHandler:^
     {
         DDLogInfo(@"搜索");
     }];
}

/** 瀑布流视图 */
- (void)addCollectionView
{
    _collectionView = [PSCollectionView new];
    _collectionView.delegate = self;
    _collectionView.collectionViewDelegate = self;
    _collectionView.collectionViewDataSource = self;
    _collectionView.numColsLandscape = 3;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.mas_equalTo(0);
     }];
    [_collectionView setHeaderView:[self headView]];
}

- (UIView *)headView
{
    UIView *headView = [UIView viewWithFrame:CGRectMake(0, 0, 0, 90*kScale)];
    [headView setBackgroundColor:kBGDColor];
    /** 白色地层视图 */
    UIView *bgdView = [UIView new];
    [bgdView setBackgroundColor:[UIColor whiteColor]];
    [bgdView.layer setCornerRadius:10*kScale];
    [headView addSubview:bgdView];
    [bgdView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.center.mas_equalTo(0);
        make.height.mas_equalTo(60*kScale);
        make.width.mas_equalTo(510*kScale);
    }];
    [bgdView bk_whenTapped:^
    {
        DDLogInfo(@"专辑");
    }];
    /** 左侧图片 */
    UIImageView *leftIcon = [UIImageView new];
    [leftIcon setImage:[UIImage imageNamed:@"icon_cyber_space_board_28x28_"]];
    [bgdView addSubview:leftIcon];
    [leftIcon mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(20*kScale);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(28*kScale);
        make.height.mas_equalTo(28*kScale);
    }];
    /** 左侧标题 */
    UILabel *titleLabel = [UILabel new];
    [titleLabel setText:@"专辑"];
    [titleLabel setFont:[UIFont systemFontOfSize:18*kScale]];
    [titleLabel setTextColor:kTextColor];
    [bgdView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(leftIcon.mas_right).mas_equalTo(15*kScale);;
        make.centerY.mas_equalTo(0);
    }];
    /** 右侧图片 */
    UIImageView *rightIcon = [UIImageView new];
    [rightIcon setImage:[UIImage imageNamed:@"home_anime_indicator_28x28_"]];
    [bgdView addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(-10*kScale);
         make.centerY.mas_equalTo(0);
         make.width.mas_equalTo(28*kScale);
         make.height.mas_equalTo(28*kScale);
     }];
    /** 右侧描述 */
    UILabel *deslabel = [UILabel new];
    [deslabel setText:@"584个专辑更新"];
    [deslabel setFont:[UIFont systemFontOfSize:14*kScale]];
    [deslabel setTextColor:[UIColor lightGrayColor]];
    [bgdView addSubview:deslabel];
    [deslabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(rightIcon.mas_left).mas_equalTo(0);;
         make.centerY.mas_equalTo(0);
     }];

    return headView;
}

/** 刷新视图 */
- (void)addRefreshView
{
    _collectionView.mj_header = [self gifHeaderWithRefreshingBlock:^
    {
        [_imagelistVM refreshDataWithCompletionHandler:^(NSError *error)
         {
             [_collectionView reloadData];
             [_collectionView.mj_header endRefreshing];
         }];
    }];
    [_collectionView.mj_header beginRefreshing];
    
    _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^
                                 {
                                     [_imagelistVM getMoreDataWithCompletionHandler:^(NSError *error)
                                      {
                                          [_collectionView reloadData];
                                          [_collectionView.mj_footer endRefreshing];
                                      }];
                                 }];
}


#pragma mark -  PSCollectionView协议方法

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return _imagelistVM.listNumber;
}

- (UIView *)collectionView:(PSCollectionView *)collectionView
         cellForRowAtIndex:(NSInteger)index
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    PDImageListCell *cell = [collectionView dequeueReusableViewForClass:[PDImageListCell class]];
#pragma clang diagnostic pop
    if (!cell)
    {
        cell = [PDImageListCell new];
    }
    [cell setDataWithViewModel:_imagelistVM index:index];
    return cell;
}

/** cell高度 **/
- (CGFloat)collectionView:(PSCollectionView *)collectionView
      heightForRowAtIndex:(NSInteger)index
{
    return [_imagelistVM cellSizeWithIndex:index].height;
}

- (void)collectionView:(PSCollectionView *)collectionView
         didSelectCell:(PSCollectionViewCell *)cell
               atIndex:(NSInteger)index
{
    DDLogInfo(@"图片话题");
}


/** 重布局 */
kLayoutView

@end
