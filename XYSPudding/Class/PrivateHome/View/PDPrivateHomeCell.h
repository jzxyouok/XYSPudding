/**
 *  自定义格式的cell
 */

#import <UIKit/UIKit.h>

@interface PDPrivateHomeCell : UITableViewCell

@property (nonatomic, strong) NSArray *cellDatas;

- (void)setCellDatas:(NSArray *)cellDatas
        clickHandler:(void(^)(NSInteger index))clickHandler;

@end
