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

@interface PDTLController ()<UIScrollViewDelegate, PSCollectionViewDelegate, PSCollectionViewDataSource>

@property (nonatomic, strong) PSCollectionView *collectionView;

@end

@implementation PDTLController

- (void)viewDidLoad
{
    [super viewDidLoad];

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

#pragma mark -  PSCollectionView协议方法

//- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
//{
//    return _imagelistVM.listNumber;
//}
//
//- (UIView *)collectionView:(PSCollectionView *)collectionView
//         cellForRowAtIndex:(NSInteger)index
//{
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
//    PDImageListCell *cell = [collectionView dequeueReusableViewForClass:[PDImageListCell class]];
//#pragma clang diagnostic pop
//    if (!cell)
//    {
//        cell = [PDImageListCell new];
//    }
//
//    return cell;
//}
//
///** cell高度 **/
//- (CGFloat)collectionView:(PSCollectionView *)collectionView
//      heightForRowAtIndex:(NSInteger)index
//{
//    return [_imagelistVM cellSizeWithIndex:index].height;
//}

@end
