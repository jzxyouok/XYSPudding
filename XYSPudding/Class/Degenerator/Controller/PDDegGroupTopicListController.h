/**
 *  小组中的话题列表控制器视图
 */

#import <UIKit/UIKit.h>

@interface PDDegGroupTopicListController : UITableViewController
/** 自定义视图配置的控制器 */
+ (id)controllerWithBgdImageURL:(NSURL *)bgdImageURL
                             id:(NSString *)id_
                      groupName:(NSString *)groupName;

/** 接收背景图url */
@property (nonatomic, strong) NSURL *bgdImageURL;
/** 接收小组id */
@property (nonatomic, strong) NSString *id_;
/** 接收小组昵称 */
@property (nonatomic, strong) NSString *groupName;
/** 视图推出方式 */
@property (nonatomic, assign, getter=isPushed) BOOL pushed;
@end
