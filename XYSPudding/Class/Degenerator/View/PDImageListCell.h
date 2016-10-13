/**
 *  图片主题展示的cell
 */

#import "PSCollectionViewCell.h"
#import "PDDegImageViewModel.h"

@interface PDImageListCell : PSCollectionViewCell

/** 获取视图模型来设置界面数据 */
- (void)setDataWithViewModel:(PDDegImageViewModel *)viewModel
                       index:(NSInteger)index;

@property (nonatomic, strong) PDDegImageViewModel *viewModel;
@property (nonatomic, assign) NSInteger index_;

@end
