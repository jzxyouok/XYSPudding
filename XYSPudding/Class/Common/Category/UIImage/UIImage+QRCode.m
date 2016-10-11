#import "UIImage+QRCode.h"

@implementation UIImage (QRCode)

#pragma mark - 将字符串转换成二维码图片格式

/*!
 *  纯二维码
 */
+ (instancetype)imageForQRCode:(NSString *)info
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"]; //创建过滤器
    [filter setDefaults]; //恢复过滤器的默认设置
    
    NSString *qRCOdeStr = info;  //将信息转换为二进制数据
    NSData *data = [qRCOdeStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKey:@"inputMessage"]; //通过KVC将生成的二进制数据传给过滤器
    
    CIImage *outputImage = [filter outputImage]; //获取过滤器生成的CIImage对象
    UIImage *qrCodeImage = [UIImage imageWithCIImage:outputImage]; //通过获取的outputImage对象生成二维码图片
    
    return qrCodeImage; //返回二维码图片
}


/*!
 *  内嵌图片的二维码
 */

+ (instancetype)imageForQRCode:(NSString *)info
                       QRCSize:(CGSize)size
                         image:(UIImage *)image
                     imageRect:(CGRect)rect
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"]; //创建过滤器
    [filter setDefaults]; //恢复过滤器的默认设置
    
    
    NSString *qRCOdeStr = info; //将信息转换为二进制数据
    NSData *data = [qRCOdeStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKey:@"inputMessage"]; //通过KVC将生成的二进制数据传给过滤器
    
    CIImage *outputImage = [filter outputImage]; //获取过滤器生成的CIImage对象
    UIImage *qrCodeImage = [UIImage imageWithCIImage:outputImage]; //通过获取的outputImage对象生成二维码图片
    
    
    /* 在二维码中绘制内嵌图片 */
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0); //开始 图形界面上下文 不透明 不缩放
    [qrCodeImage drawInRect:CGRectMake(0, 0, size.width, size.height)]; //将生成的二维码图片区域内勾勒绘制到矩形区域形成二维码区域
    
    UIImage *headerImage = image; //获取要嵌入的图片
    [headerImage drawInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)]; //将要嵌入的图片绘制到指定二维码区域中形成内嵌区域
    
    UIImage *newQRCodeImage = UIGraphicsGetImageFromCurrentImageContext(); //通过当前上下文得到新的二维码图片
    
    UIGraphicsEndImageContext(); //结束 图形界面上下文
    
    return newQRCodeImage; //返回新的二维码图片
}


@end
