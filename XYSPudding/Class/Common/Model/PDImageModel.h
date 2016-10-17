/**
 *  网络图片模型
 */

#import "XYSBaseModel.h"

@interface PDImageModel : XYSBaseModel

/** 图片URL地址 */
@property (nonatomic, copy) NSString *url;
/** 图片宽度 */
@property (nonatomic, assign) NSInteger width;
/** 图片高度 */
@property (nonatomic, assign) NSInteger height;
/** 是否是Gif图片 */
@property (nonatomic, assign) BOOL isGif;

@end
