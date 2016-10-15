#import "UIImage+Size.h"

@implementation UIImage (Size)

/*!
 *  缩略图
 *
 */
-(UIImage *)zoomOutToSize:(CGSize)size;
{
    UIGraphicsBeginImageContext(size); //开启画布
   
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)]; //绘制图片
    UIImage *thumbnail=UIGraphicsGetImageFromCurrentImageContext(); //获取图片
    
    UIGraphicsEndImageContext(); //回收画布
    
    return thumbnail; //返回缩略图
}


/*!
 *  缩略图
 */
-(UIImage *)zoomOutAndClipToSize:(CGSize)size;
{
    if (size.width == 0 || size.height == 0)
    {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0); //开启画布
    
    CGFloat width = size.width;  //获取调整后的图片宽高，构建图片大小
    CGFloat height = width * self.size.height / self.size.width;
    [self drawInRect:CGRectMake(0, 0, width, height)]; //绘制图片
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext(); //获取图片
    
    UIGraphicsEndImageContext(); //回收画布
    
    return thumbnail; //返回缩略图
}
@end
