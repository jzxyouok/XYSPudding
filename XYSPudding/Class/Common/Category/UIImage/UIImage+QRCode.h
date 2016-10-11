/*!
 *  设置二维码
 *
 *
 */

#import <UIKit/UIKit.h>

@interface UIImage (QRCode)

/*
 *  将字符串转换成二维码
 */
+ (instancetype)imageForQRCode:(NSString *)info;

/*!
 *  内嵌图片的二维码
 *
 *  @param info  字符串信息
 *  @param size  二维码大小
 *  @param image 内嵌图片大小
 *  @param rect  图片frame
 *
 */
+ (instancetype)imageForQRCode:(NSString *)info
                       QRCSize:(CGSize)size
                         image:(UIImage *)image
                     imageRect:(CGRect)rect; //内嵌图片的二维码

@end
