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

@end
