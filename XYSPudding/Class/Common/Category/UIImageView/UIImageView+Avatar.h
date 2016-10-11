/*
    名称： UIImageView的分类（Avatar）
 
    作用：通过网络加载头像图片
 
    目的：设置头像
*/

#import <UIKit/UIKit.h>

@interface UIImageView (Avatar)
/**
 *  设置头像
 *
 *  @param url 图片资源网络定位符
 */
- (void)setCircleAvatarWithURL:(NSURL *)url;

/*!
 *  设置视图圆形
 */
- (void)circle;

@end
