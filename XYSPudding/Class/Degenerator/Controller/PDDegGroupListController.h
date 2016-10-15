/**
 *  展示所有分组的视图控制器
 */

#import <UIKit/UIKit.h>

/** 分组风格 */
typedef NS_ENUM(NSInteger, PDDegGroupStyle)
{
    /** 普通展示，展示8个 */
    PDDegGroupStyleNormal = 0,
    /** 通过刷新展示所有 */
    PDDegGroupStyleAll = 1
};
@interface PDDegGroupListController : UITableViewController

/** 带导航栏的本控制器视图配置在自定义窗口，返回该窗口对象 */
+ (id)standardWindowWithController;

@property (nonatomic, assign) PDDegGroupStyle style;

@end
