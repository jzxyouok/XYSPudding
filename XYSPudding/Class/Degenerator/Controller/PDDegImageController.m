//
//  PDDegImageController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegImageController.h"
#import "PSCollectionView.h"
#import "PDDegImageViewModel.h"
#import "PDWindow.h"
#import "UIViewController+NavigationItem.h"
#import "PDImageListCell.h"

@interface PDDegImageController ()<UIScrollViewDelegate, PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, strong) PDDegImageViewModel *listViewModel;

@end

@implementation PDDegImageController

/** 带导航栏的本控制器视图配置在自定义窗口，返回该窗口对象 */
+ (id)standardWindowWithController
{
    PDWindow *pWindow = [PDWindow standardWindow];
    pWindow.rootViewController = [PDDegImageController new];
    return pWindow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"图片"];
    [self.view setBackgroundColor:kBGDColor];
    [self addNavigationItems];
    
    _listViewModel = [PDDegImageViewModel new];
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
}

/** 刷新视图 */
- (void)addRefreshView
{
    _collectionView.mj_header = [self gifHeaderWithRefreshingBlock:^
    {
        [_listViewModel refreshDataWithCompletionHandler:^(NSError *error)
         {
             [_collectionView reloadData];
             [_collectionView.mj_header endRefreshing];
         }];
    }];
    [_collectionView.mj_header beginRefreshing];
    
    _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^
                                 {
                                     [_listViewModel getMoreDataWithCompletionHandler:^(NSError *error)
                                      {
                                          [_collectionView reloadData];
                                          [_collectionView.mj_footer endRefreshing];
                                      }];
                                 }];
}


#pragma mark -  PSCollectionView协议方法

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return _listViewModel.listNumber;
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
    [cell setDataWithViewModel:_listViewModel index:index];
    return cell;
}

/** cell高度 **/
- (CGFloat)collectionView:(PSCollectionView *)collectionView
      heightForRowAtIndex:(NSInteger)index
{
    return [_listViewModel cellSizeWithIndex:index].height;
}

/** 重布局 */
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(44*kScale);
    }];
}

@end
