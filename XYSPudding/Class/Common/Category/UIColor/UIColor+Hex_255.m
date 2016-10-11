#import "UIColor+Hex_255.h"

@implementation UIColor (Hex_255)

#pragma mark - 设置 RGB 颜色

+ (UIColor *)colorWith255Red:(NSInteger)red
                       green:(NSInteger)green
                        blue:(NSInteger)blue
                       alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}


#pragma mark - 通过十六进制数 设置颜色

/* HEX RED: 0xFF0000   HEX GREEN:0x00FF00  HEX BLUE:0x0000FF */

+ (UIColor *)colorWithHex:(long)hex alpha:(CGFloat)alpha
{
    float red = ((float)((hex & 0xFF0000)>>16))/255.0; //红色
    
    float green = ((float)((hex & 0x00FF00)>>8))/255.0; //绿色
    
    float blue = ((float)((hex & 0x0000FF)>>0))/255.0; //蓝色
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHex:(long)hex
{
    return [UIColor colorWithHex:hex alpha:1];
}

@end
