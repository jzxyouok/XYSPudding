/**
 *  展示部分小组的cell
 */

#import <UIKit/UIKit.h>
#import "PDDegGroupViewModel.h"

@interface PDDegGroupCell : UITableViewCell

/** 接收视图模型对象 */
@property (nonatomic, strong) PDDegGroupViewModel *groupViewModel;

- (void)setDataWithViewModel:(PDDegGroupViewModel *)groupViewModel
                clickHandler:(void(^)(NSInteger index))handler;

@end
