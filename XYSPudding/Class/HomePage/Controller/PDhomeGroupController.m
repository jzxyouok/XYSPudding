//
//  PDhomeGroupController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDhomeGroupController.h"
#import "PDAnimeGroupListViewModel.h"
#import "PDAnimeGroupCell.h"
#import "PDHPGroupCell.h"

@interface PDhomeGroupController ()
{
    /** 记录分组展示的动画列表视图模型 */
    PDAnimeGroupListViewModel *_animeGroupListVM;
}
/** 记录番组推荐模型 */
@property (nonatomic, strong) PDHPGroupViewModel *recommendModel;
/** 记录最近更新模型 */
@property (nonatomic, strong) PDHPGroupViewModel *latesModel;
/** 记录国产动漫模型 */
@property (nonatomic, strong) PDHPGroupViewModel *domesticModel;
/** 记录完结推荐模型 */
@property (nonatomic, strong) PDHPGroupViewModel *endRModel;

/** 记录分组模型 */
@property (nonatomic, strong) NSMutableArray *groupModels;

@end

@implementation PDhomeGroupController

/** 记录番组推荐模型 */
- (PDHPGroupViewModel *)recommendModel
{
    if (!_recommendModel)
    {
        _recommendModel = [[PDHPGroupViewModel alloc] initWithGroupStyle:PDHPGroupStyleRecommend];
    }
    return _recommendModel;
}
/** 记录最近更新模型 */
- (PDHPGroupViewModel *)latesModel
{
    if (!_latesModel)
    {
        _latesModel = [[PDHPGroupViewModel alloc] initWithGroupStyle:PDHPGroupStyleLatest];
    }
    return _latesModel;
}
/** 记录国产动漫模型 */
- (PDHPGroupViewModel *)domesticModel
{
    if (!_domesticModel)
    {
        _domesticModel = [[PDHPGroupViewModel alloc] initWithGroupStyle:PDHPGroupStyleDomesticAnimation];
    }
    return _domesticModel;
}
/** 记录完结推荐模型 */
- (PDHPGroupViewModel *)endRModel
{
    if (!_endRModel)
    {
        _endRModel = [[PDHPGroupViewModel alloc] initWithGroupStyle:PDHPGroupStyleEndRecommend];
    }
    return _endRModel;
}
/** 记录分组模型 */
- (NSMutableArray *)groupModels
{
    if (!_groupModels)
    {
        _groupModels = [NSMutableArray arrayWithArray:@[self.recommendModel,
                                                        self.latesModel,
                                                        self.domesticModel,
                                                        self.endRModel]];
    }
    return _groupModels;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerClass:[PDAnimeGroupCell class]
                         forCellWithReuseIdentifier:@"AnimeGroupCell"];
    [self.collectionView registerClass:[PDHPGroupCell class]
            forCellWithReuseIdentifier:@"GroupCell"];

    
    [self.collectionView setBackgroundColor:kBGDColor];
    [self addRefreshView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 添加刷新页面 */
- (void)addRefreshView
{
    _animeGroupListVM = [PDAnimeGroupListViewModel new];
    self.collectionView.mj_header = [self gifHeaderWithRefreshingBlock:^
                                {
                                    [self freshGroupData];
                                    [_animeGroupListVM refreshDataWithCompletionHandler:^(NSError *error)
                                     {
                                         if (!error)
                                         {
                                             [self.collectionView reloadData];
                                         }
                                         [self.collectionView.mj_header endRefreshing];
                                     }];
                                }];
    
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^
    {
        [_animeGroupListVM getMoreDataWithCompletionHandler:^(NSError *error)
        {
            if (!error)
            {
                [self.collectionView reloadData];
            }
            [self.collectionView.mj_footer endRefreshing];
        }];
    }];
}

- (void)freshGroupData
{
//    [self.recommendModel refreshDataWithCompletionHandler:^(NSError *error)
//     {
//         if (!error)
//         {
//             [self.collectionView reloadData];
//         }
//     }];
//    [self.latesModel refreshDataWithCompletionHandler:^(NSError *error)
//     {
//         if (!error)
//         {
//             [self.collectionView reloadData];
//         }
//     }];
    [self.domesticModel refreshDataWithCompletionHandler:^(NSError *error)
     {
         if (!error)
         {
             [self.collectionView reloadData];
         }
     }];
    [self.endRModel refreshDataWithCompletionHandler:^(NSError *error)
     {
         if (!error)
         {
             [self.collectionView reloadData];
         }
     }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionVie
{
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.groupModels.count;
    }
    return _animeGroupListVM.groupNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        PDHPGroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupCell"
                                                                           forIndexPath:indexPath];
        [cell setDataWithViewModel:self.groupModels[indexPath.row]
                             index:indexPath.row];
        return cell;
    }
    
    PDAnimeGroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnimeGroupCell"
                                                                           forIndexPath:indexPath];
    [cell setDataWithViewModel:_animeGroupListVM
                         index:indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

/** 四周边距 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 14*kScaleW, 0, 14*kScaleW);
}

/* 行间距 */
-(CGFloat)           collectionView:(UICollectionView *)collectionView
                             layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 14*kScaleW;
}

/* 列间距 */
-(CGFloat)                collectionView:(UICollectionView *)collectionView
                                  layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 14*kScaleW;
}

/** 每个cell的size */
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = 491*kScaleW;
    CGFloat height = 0;
    if (indexPath.section == 0)
    {
        height = 555*kScaleW;
    }
    if (indexPath.section == 1)
    {
        height = 240*kScaleW;
    }
    return CGSizeMake(width, height);
}

/* 许可高亮状态 */
- (BOOL)        collectionView:(UICollectionView *)collectionView
shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
    [cell setBackgroundColor:kBGDColor];
}

@end
