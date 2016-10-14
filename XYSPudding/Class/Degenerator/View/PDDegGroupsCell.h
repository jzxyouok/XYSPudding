/**
 *  展示小组信息的cell
 */

#import <UIKit/UIKit.h>
#import "PDDegGroupViewModel.h"

@interface PDDegGroupsCell : UITableViewCell

/** 接收视图模型对象 */
- (void)setDataWithViewModel:(PDDegGroupViewModel *)groupViewModel
                       index:(NSInteger)index;
@property (nonatomic, strong, readonly) PDDegGroupViewModel *groupViewModel;
@property (nonatomic, assign, readonly) NSInteger index;

@end
