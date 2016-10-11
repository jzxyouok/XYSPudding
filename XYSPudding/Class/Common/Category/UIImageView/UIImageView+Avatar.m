#import "UIImageView+Avatar.h"
#import "UIImage+Circle.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Avatar)

/*!
 *  设置圆形头像
 */
- (void)setCircleAvatarWithURL:(NSURL *)url;
{
    UIImage *placeHolderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage]; //设置预留图片
    
    [self sd_setImageWithURL:url
            placeholderImage:placeHolderImage
                   completed:^(UIImage *image,
                               NSError *error,
                               SDImageCacheType cacheType,
                               NSURL *imageURL) {
                       self.image = image ? [image circleImage] : placeHolderImage; //加载结束后，设置图片
                   }];
}

/*!
 *  设置视图圆形
 */
- (void)circle
{
    CGFloat r = MIN(self.bounds.size.width, self.bounds.size.height);
    self.layer.cornerRadius = r * 0.5;
}

@end
