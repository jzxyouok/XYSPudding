//
//  PDPropController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/14.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDPropController.h"
#import "PDPropGoodsListViewModel.h"
#import "PDPropListCell.h"

@interface PDPropController ()
{
    /** 记录商品列表数据模型对象 */
    PDPropGoodsListViewModel *_goodsListVM;
}
@end

@implementation PDPropController

+ (instancetype)new
{
    UICollectionViewFlowLayout *flowlayout = [UICollectionViewFlowLayout new];
    PDPropController *propController = [[PDPropController alloc] initWithCollectionViewLayout:flowlayout];
    return propController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView setBackgroundColor:kBGDColor];
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerClass:[PDPropListCell class]
            forCellWithReuseIdentifier:@"ListCell"];
    
    _goodsListVM = [PDPropGoodsListViewModel new];
    self.collectionView.mj_header = [self gifHeaderWithRefreshingBlock:^
    {
        [_goodsListVM refreshDataWithCompletionHandler:^(NSError *error)
        {
            if (!error)
            {
                [self.collectionView reloadData];
                [self.collectionView.mj_header endRefreshing];
            }
        }];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^
    {
        [_goodsListVM getMoreDataWithCompletionHandler:^(NSError *error)
        {
            if (!error)
            {
                [self.collectionView reloadData];
                [self.collectionView.mj_footer endRefreshing];
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return _goodsListVM.goodsNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PDPropListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCell"
                                                                           forIndexPath:indexPath];
    [cell setDataWithViewModel:_goodsListVM index:indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

//四周边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(14*kScaleW, 14*kScaleW, 14*kScaleW, 14*kScaleW);
}

//行间距
-(CGFloat)           collectionView:(UICollectionView *)collectionView
                             layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 14*kScaleW;
}

//列间距
-(CGFloat)                collectionView:(UICollectionView *)collectionView
                                  layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 14*kScaleW;
}

//每个cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(238.5*kScaleW, 320*kScaleW);
}


@end
