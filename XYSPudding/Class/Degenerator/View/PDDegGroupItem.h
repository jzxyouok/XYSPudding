/**
 *  展示部分小组的cell中的小组标签
 */

#import <UIKit/UIKit.h>

typedef void(^ClickHandler)(NSInteger tag);

@interface PDDegGroupItem : UIView

/** 图片URL */
@property (nonatomic, strong) NSURL *imageURL;
/** 标题 */
@property (nonatomic, strong) NSString *title;

/** 点击回调 */
@property (nonatomic, copy) ClickHandler clickHandler;
- (void)clickHandler:(ClickHandler)clickHandler;

@end
