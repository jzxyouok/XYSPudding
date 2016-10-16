//
//  PDPropListCell.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDPropGoodsListViewModel.h"

@interface PDPropListCell : UICollectionViewCell

- (void)setDataWithViewModel:(PDPropGoodsListViewModel *)viewModel
                       index:(NSInteger)index;
@property (nonatomic, strong, readonly) PDPropGoodsListViewModel *viewModel;
@property (nonatomic, assign, readonly) NSInteger index;

@end
