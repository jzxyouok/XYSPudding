#import "UIImage+Circle.h"

@implementation UIImage (Circle)

- (UIImage *)circleImage
{
    CGFloat circleWidth = MAX(self.size.width, self.size.height); //获取圆形宽度
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleWidth, circleWidth), NO, 0); //创建方形图片画布(不透明 不缩放)
    
    CGContextRef context = UIGraphicsGetCurrentContext(); //获取当前的画布
    
    //勾勒图形
    CGRect circleRect = CGRectMake(0, 0, circleWidth, circleWidth); //设置圆外的方形框
    CGContextAddEllipseInRect(context, circleRect); //在方形框内绘制圆
    CGContextClip(context); //裁剪（圆形外不可绘图）
    [self drawInRect:circleRect]; //将图片画上去
    
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext(); //获取画布内的自制图片
    
    UIGraphicsEndImageContext(); //回收图片画布
    
    return circleImage; //返回图片
}


/*!
 *  带边界的圆形图片
 */
+ (instancetype)imageWithName:(NSString *)name
                  borderWidth:(CGFloat)width
                  borderColor:(UIColor *)color
{
    UIImage *oldImage = [UIImage imageNamed:name]; //获取旧的图片资源
    
    /* 获取圆形画布的宽度 */
    CGFloat imageWidth = oldImage.size.width; //原图片的宽
    CGFloat imageHeight = oldImage.size.height; //原图片的高
    CGFloat circleWidth = MIN(imageWidth, imageHeight) + 2*width; //取原图宽高的最大值+边框宽 形成圆心画布的宽度
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleWidth, circleWidth), NO, 0.0); //开始 图形界面上下文 (不透明 不缩放)
    
    /* 绘制圆形图案(包括边界) */
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleWidth, circleWidth)]; //创建并勾勒圆形画布
    [color setFill]; //设置画布填充色
    [path fill]; //绘制圆形图案
    
    
    CGRect insideRect = CGRectMake(width, width, circleWidth-2*width, circleWidth-2*width);
    
    /* 制圆形边界以内的圆形 */
    UIBezierPath *insidePath = [UIBezierPath bezierPathWithOvalInRect:insideRect]; //创建并勾勒内部圆形画布
    [insidePath addClip]; //剪切 内部圆形画布以外的部分不可绘制
    [oldImage drawInRect:insideRect]; //绘制内部圆形图案
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext(); //从当前上下文中获取绘制的图片
    
    UIGraphicsEndImageContext(); //结束 图形界面上下文
    
    return  newImage;//返回得到的圆形图案
}

@end
