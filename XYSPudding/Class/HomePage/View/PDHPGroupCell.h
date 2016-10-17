//
//  PDHPGroupCell.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDHPGroupViewModel.h"

@interface PDHPGroupCell : UICollectionViewCell

- (void)setDataWithViewModel:(PDHPGroupViewModel *)viewModel
                       index:(NSInteger)index;

@property (nonatomic, strong) PDHPGroupViewModel *viewModel;
@property (nonatomic, assign) NSInteger index;

@end
