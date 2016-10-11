#import "UIButton+setState.h"

@implementation UIButton (setState)

/*!
 *  快速设置背景图片
 */
- (void)normalBGDImage:(UIImage *)image
{
   [self setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)highlightBGDImage:(UIImage *)image
{
   [self setBackgroundImage:image forState:UIControlStateHighlighted];
}

- (void)selectedBGDImage:(UIImage *)image
{
    [self setBackgroundImage:image forState:UIControlStateSelected];
}

- (void)disabledBGDImage:(UIImage *)image
{
    [self setBackgroundImage:image forState:UIControlStateDisabled];
}


/*!
 *  快速设置图片
 */
- (void)normalImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}
- (void)highlightImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateHighlighted];
}
- (void)selectedImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateSelected];
}
- (void)disabledImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateDisabled];
}

/*!
 *  快速设置标题
 */
- (void)normalTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)highlightTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateHighlighted];
}
- (void)selectedTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateSelected];
}
- (void)disabledTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateDisabled];
}

/*!
 *  快速设置标题颜色
 */
- (void)normalTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}
- (void)highlightTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateHighlighted];
}
- (void)selectedTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateSelected];
}
- (void)disabledTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateDisabled];
}

@end
