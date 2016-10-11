#import "UIImage+Capture.h"

@implementation UIImage (Capture)

#pragma mark - 选择对应的图层进行截屏

+ (instancetype)imageWithCapture:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.bounds.size.width, view.bounds.size.height), NO, 0.0); //开始 界面图形上下文（创建画布）
    
    CGContextRef context = UIGraphicsGetCurrentContext(); //获取当前区域内的图形上下文
    
    [view.layer renderInContext:context]; //图层渲染到画布中
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext(); //从当前的上下文中获取截图
    
    UIGraphicsEndImageContext(); //结束 界面图形上下文（回收画布）
    
    return newImage; //返回截屏图片
}

/*!
 *   自动存储截屏图片到指定位置
 */
+ (instancetype)imageWithCapture:(UIView *)view
                   stroeFilePath:(NSString *)filePath
{
    UIImage *captureImage = [UIImage imageWithCapture:view]; //获取截屏图片资源
    
    NSData *data = UIImagePNGRepresentation(captureImage);//将截屏图片无损压缩 形成二进制文件
    
    /* 通过当地时间进行图片的命名 */
    NSDate *date = [[NSDate alloc] init];
    NSLocale *usLocale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];//地区标识
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.locale=usLocale;
    [dateFormatter setDateFormat:@"yyyy-MM-dd.hh:mm:ss"];//时间格式
    NSString *dateStr = [dateFormatter stringFromDate:date];//时间字符串
    NSString *imageName = [dateStr stringByAppendingString:@"截图.png"];//用日期生成图片名
    
    [data writeToFile:[filePath stringByAppendingString:imageName] atomically:YES]; //将截屏图片存到指定位置
    
    return captureImage; //返回截屏图片
}


@end
