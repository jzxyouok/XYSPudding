//
//  NSObject+XYSFactory.m
//  XYSBaseProject
//
//  Created by 徐玉珊 on 16/9/29.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "NSObject+XYSFactory.h"

@implementation NSObject (XYSFactory)

/** 获取缓存文件大小 */
+ (CGFloat)getSizeOfCache
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *cacheFilePaths = [fileManager subpathsOfDirectoryAtPath:kCachePath error:nil];
    
    long long cacheSize = 0;
    for (NSString *cacheFileName in cacheFilePaths)
    {
        NSString *cacheFilePath = [kCachePath stringByAppendingPathComponent:cacheFileName];
        NSDictionary *cacheFile = [fileManager attributesOfItemAtPath:cacheFilePath error:nil];
        cacheSize += [cacheFile fileSize];
    }
    
    return (CGFloat)cacheSize/1024.0/1024; //MB
}

/** 清除缓存文件 */
+ (void)clearCacheFiles
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [UIAlertView bk_showAlertViewWithTitle:@"确定清理缓存吗"
                                   message:nil
                         cancelButtonTitle:@"确定"
                         otherButtonTitles:@[@"取消"]
                                   handler:^(UIAlertView *alertView,
                                             NSInteger buttonIndex)
     {
         if (buttonIndex == 1)
         {
             return ;
         }
     }];
#pragma clang diagnostic pop
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^
                   {
                       NSFileManager *fileManager = [NSFileManager defaultManager];
                       
                       NSArray *cacheFilePaths = [fileManager subpathsAtPath:kCachePath];
                       for (NSString *cacheFileName in cacheFilePaths)
                       {
                           NSError *error = nil;
                           NSString *cacheFilePath = [kCachePath stringByAppendingPathComponent:cacheFileName];
                           if ([fileManager fileExistsAtPath:cacheFilePath])
                           {
                               [fileManager removeItemAtPath:cacheFilePath error:&error];
                           }
                       }
                       
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [SVProgressHUD showSuccessWithStatus:@"清除成功"];
                                          [SVProgressHUD dismissWithDelay:2.0];
                                      });
                   });
}

/** 获取app版本号 */
+ (NSString *)getAppVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary]; //获取info.plist文件
    return infoDic[@"CFBundleShortVersionString"];
}


@end
