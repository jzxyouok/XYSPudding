/**
 *    名称：XYSTabBarDataModel
 *
 *    作用：存储选择栏属性信息
 *
 *    目的：存储数据
 */

#import "XYSBaseModel.h"

@interface XYSTabBarModel : XYSBaseModel

/** 控制器视图 */
@property (nonatomic, copy) NSString *viewController;
/** 标签标题 */
@property (nonatomic, copy) NSString *title;
/** normal状态下的图片 */
@property (nonatomic, copy) NSString *normalImage;
/** selected状态下的图片 */
@property (nonatomic, copy) NSString *selectedImage;

/** 对象模型数组 */
+ (NSArray *)getModels;

/** 通过字典传入属性值，init对象 */
+ (instancetype)modelWithDictionary:(NSDictionary *)dic;

@end