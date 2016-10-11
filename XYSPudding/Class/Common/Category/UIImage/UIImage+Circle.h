/*
    名称： UIImage的分类（Circle）
 
    作用：将图片转变为圆形图片；
 
    目的：获取圆形图片。
 */


#import <UIKit/UIKit.h>

@interface UIImage (Circle)

/*!
 *  获取方形圆图片
 */
- (UIImage *)circleImage;

/*!
 *  带边界的圆形图片
 */
+ (instancetype)imageWithName:(NSString *)name
                  borderWidth:(CGFloat)borderWidth
                  borderColor:(UIColor *)color;
@end
