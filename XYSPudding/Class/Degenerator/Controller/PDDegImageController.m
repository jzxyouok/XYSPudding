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
#import "PDShowViewController.h"
#import "UIViewController+NavigationItem.h"
#import "PDImageListCell.h"

@interface PDDegImageController ()<UIScrollViewDelegate, PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, strong) PDDegImageViewModel *listViewModel;

@end

@implementation PDDegImageController

/** 自定义视图配置的控制器 */
+ (id)defaultController
{
    PDShowViewController *showVC = [PDShowViewController new];
    showVC.viewController = [PDDegImageController new];
    
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
    [self addCollectionView];
    [self addRefreshView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    MJRefreshGifHeader * gifRefreshHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^
                                             {
                                                 [_listViewModel refreshDataWithCompletionHandler:^(NSError *error)
                                                  {
                                                      [_collectionView reloadData];
                                                      [_collectionView.mj_header endRefreshing];
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
    _collectionView.mj_header = gifRefreshHeader;
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
    PDImageListCell *cell = [collectionView dequeueReusableViewForClass:[PDImageListCell class]];
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


@end
