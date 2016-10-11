/*
    名称：UIColor的分类(Hex_255)
 
    作用：定义并实现255格式的RGB颜色设置；
         实现十六进制数来设置颜色。
 
    目的：快速使用，封装代码，增加代码的简洁性和可读性，提高编程效率。
*/

#import <UIKit/UIKit.h>

@interface UIColor (Hex_255)

/*
 *  快速设置整255格式的RGB颜色
 */
+ (UIColor *)colorWith255Red:(NSInteger)red
                       green:(NSInteger)green
                        blue:(NSInteger)blue
                       alpha:(CGFloat)alpha;

/*
 * 快速设置整十六进制的颜色。
 */
+ (UIColor *)colorWithHex:(long)hex alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(long)hex;

@end
