#import <UIKit/UIKit.h>

@interface UIButton (setState)

/*!
 *  快速设置背景图片
 */
- (void)normalBGDImage:(UIImage *)image;
- (void)highlightBGDImage:(UIImage *)image;
- (void)selectedBGDImage:(UIImage *)image;
- (void)disabledBGDImage:(UIImage *)image;

/*!
 *  快速设置图片
 */
- (void)normalImage:(UIImage *)image;
- (void)highlightImage:(UIImage *)image;
- (void)selectedImage:(UIImage *)image;
- (void)disabledImage:(UIImage *)image;

/*!
 *  快速设置标题
 */
- (void)normalTitle:(NSString *)title;
- (void)highlightTitle:(NSString *)title;
- (void)selectedTitle:(NSString *)title;
- (void)disabledTitle:(NSString *)title;

/*!
 *  快速设置标题颜色
 */
- (void)normalTitleColor:(UIColor *)color;
- (void)highlightTitleColor:(UIColor *)color;
- (void)selectedTitleColor:(UIColor *)color;
- (void)disabledTitleColor:(UIColor *)color;

@end
