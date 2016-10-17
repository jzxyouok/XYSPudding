//
//  PDAnimeGroupCell.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDAnimeGroupListViewModel.h"

@interface PDAnimeGroupCell : UICollectionViewCell

- (void)setDataWithViewModel:(PDAnimeGroupListViewModel *)viewModel
                       index:(NSInteger)index;
@property (nonatomic, strong) PDAnimeGroupListViewModel *viewModel;
@property (nonatomic, assign) NSInteger index;

@end
