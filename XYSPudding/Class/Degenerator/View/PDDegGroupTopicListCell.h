//
//  PDDegGroupTopicCell.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/14.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDDegGroupTopicListViewModel.h"

@interface PDDegGroupTopicListCell : UITableViewCell

/** 获取视图模型设置截面数据 */
- (void)setDataWithViewModel:(PDDegGroupTopicListViewModel *)viewModel
                       index:(NSInteger)index;
@property (nonatomic, strong, readonly) PDDegGroupTopicListViewModel *viewModel;
@property (nonatomic, assign) NSInteger index;

@end
