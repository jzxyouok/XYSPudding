//
//  PDTLTopicCell.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/16.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionViewCell.h"
#import "PDTLTopicViewModel.h"

@interface PDTLTopicCell : PSCollectionViewCell

/** 获取视图模型设置截面数据 */
- (void)setDataWithViewModel:(PDTLTopicViewModel *)viewModel
                       index:(NSInteger)index_;
@property (nonatomic, strong, readonly) PDTLTopicViewModel *viewModel;
@property (nonatomic, assign) NSInteger index_;

@end
