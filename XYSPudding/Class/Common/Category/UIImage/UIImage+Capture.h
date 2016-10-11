#import <UIKit/UIKit.h>

@interface UIImage (Capture)

/*
 选择对应的图层进行截屏
 */
+ (instancetype)imageWithCapture:(UIView *)view;
+ (instancetype)imageWithCapture:(UIView *)view
                   stroeFilePath:(NSString *)filePath;

@end
