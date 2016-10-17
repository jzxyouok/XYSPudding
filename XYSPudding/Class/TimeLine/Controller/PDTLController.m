//
//  PDTLController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDTLController.h"
#import "PSCollectionView.h"
#import "PDImageListCell.h"
#import "PDTLTopicViewModel.h"
#import "PDTLTopicCell.h"

@interface PDTLController ()<UIScrollViewDelegate, PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, strong) PDTLTopicViewModel *topicVM;

@end

@implementation PDTLController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:kBGDColor];
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
    _collectionView.numColsLandscape = 2;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.mas_equalTo(0);
     }];
}

/** 刷新视图 */
- (void)addRefreshView
{
    _topicVM = [PDTLTopicViewModel new];
    _collectionView.mj_header = [self gifHeaderWithRefreshingBlock:^
                                 {
                                     [_topicVM refreshDataWithCompletionHandler:^(NSError *error)
                                     {
                                         if (!error)
                                         {
                                             [_collectionView reloadData];
                                         }
                                         [_collectionView.mj_header endRefreshing];
                                     }];
                                 }];
    
    _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^
                                 {
                                    [_topicVM getMoreDataWithCompletionHandler:^(NSError *error)
                                    {
                                        if (!error)
                                        {
                                            [_collectionView reloadData];
                                        }
                                        [_collectionView.mj_footer endRefreshing];
                                    }];
                                 }];
}

#pragma mark -  PSCollectionView协议方法

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return _topicVM.listNumber;
}

- (UIView *)collectionView:(PSCollectionView *)collectionView
         cellForRowAtIndex:(NSInteger)index
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    PDTLTopicCell *cell = [collectionView dequeueReusableViewForClass:[PDTLTopicCell class]];
#pragma clang diagnostic pop
    if (!cell)
    {
        cell = [PDTLTopicCell new];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    [cell setDataWithViewModel:_topicVM index:index];

    return cell;
}

/** cell高度 **/
- (CGFloat)collectionView:(PSCollectionView *)collectionView
      heightForRowAtIndex:(NSInteger)index
{
    return [_topicVM heightOfCellWithIndex:index];
}

@end
