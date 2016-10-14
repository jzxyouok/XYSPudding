/**
 *  小组中的话题列表控制器视图
 */

#import <UIKit/UIKit.h>

@interface PDDegGroupTopicListController : UITableViewController

/** 自定义视图配置的控制器 */
+ (id)defaultControllerWithBgdImageURL:(NSURL *)bgdImageURL;

/** 接收背景图url */
@property (nonatomic, strong) NSURL *bgdImageURL;

@end
