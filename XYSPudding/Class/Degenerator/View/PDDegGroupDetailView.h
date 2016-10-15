/**
 *  展示单个小组详细信息的视图
 */

#import <UIKit/UIKit.h>
#import "PDDegGroupDetailViewModel.h"

@interface PDDegGroupDetailView : UIImageView

/** 接收小组详情视图模型 */
@property (nonatomic, strong) PDDegGroupDetailViewModel *groupDetailVM;

@end
