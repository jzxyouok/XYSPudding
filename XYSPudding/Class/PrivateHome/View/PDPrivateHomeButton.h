/**
 *  自定义格式的cell上的按钮
 */

#import <UIKit/UIKit.h>

typedef void(^ClickHandler)(NSInteger tag);

@interface PDPrivateHomeButton : UIView

/** 图片资源本地名称 */
@property (nonatomic, strong) NSString *imageName;
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 点击回调 */
@property (nonatomic, copy) ClickHandler clickHandler;
- (void)clickHandler:(ClickHandler)clickHandler;

@end
