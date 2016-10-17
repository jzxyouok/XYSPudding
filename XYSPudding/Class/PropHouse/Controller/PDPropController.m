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
#import "PDProCatogryGoodsCell.h"
#import "PDProNormalCell.h"

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
    [self.collectionView registerClass:[PDProNormalCell class]
            forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView registerClass:[PDProCatogryGoodsCell class]
            forCellWithReuseIdentifier:@"CatogryCell"];
    [self.collectionView registerClass:[PDPropListCell class]
            forCellWithReuseIdentifier:@"ListCell"];
    
    [self addRefreshView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 添加刷新页面 */
- (void)addRefreshView
{
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (_goodsListVM.goodsNumber > 0)
    {
        return 3;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return _goodsListVM.goodsNumber;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        PDProCatogryGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CatogryCell"
                                                                               forIndexPath:indexPath];
        [cell setGoodsListVM:_goodsListVM];
        return cell;
        
    }
    if (indexPath.section == 1)
    {
        PDProNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                                          forIndexPath:indexPath];
        return cell;
    }
    
    PDPropListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCell"
                                                                     forIndexPath:indexPath];
    [cell setDataWithViewModel:_goodsListVM index:indexPath.row];

    return cell;
}

- (void)  collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return;
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

/** 设置(Highlight)高亮下的颜色 */
- (void)     collectionView:(UICollectionView *)colView
didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.2]];
}
/** 设置(Nomal)正常状态下的颜色 */
- (void)collectionView:(UICollectionView *)colView
didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark <UICollectionViewDelegateFlowLayout>

//四周边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2)
    {
        return UIEdgeInsetsMake(14*kScaleW, 14*kScaleW, 14*kScaleW, 14*kScaleW);
    }
    return UIEdgeInsetsMake(0, 0, 14*kScaleW, 0);
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
    if (indexPath.section == 0)
    {
        return CGSizeMake(kScreenWidth, 120*kScaleW);
    }
    if (indexPath.section == 1)
    {
        return CGSizeMake(kScreenWidth, 50*kScaleW);
    }
    return CGSizeMake(238.5*kScaleW, 320*kScaleW);
}

@end
