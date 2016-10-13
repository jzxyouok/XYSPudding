#import "UIImageView+Avatar.h"
#import "UIImage+Circle.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Avatar)

/*!
 *  设置圆形头像
 */
- (void)setCircleAvatarWithURL:(NSURL *)url
              placeholderImage:(UIImage *)placeholderImage
{
    [self sd_setImageWithURL:url
            placeholderImage:[placeholderImage circleImage]
                   completed:^(UIImage *image,
                               NSError *error,
                               SDImageCacheType cacheType,
                               NSURL *imageURL)
     {
         if (image)
         {
             self.image = [image circleImage];
         }
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
