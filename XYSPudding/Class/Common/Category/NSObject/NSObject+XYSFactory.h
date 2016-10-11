//
//  NSObject+XYSFactory.h
//  XYSBaseProject
//
//  Created by 徐玉珊 on 16/9/29.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XYSFactory)

/** 获取缓存文件大小 */
+ (CGFloat)getSizeOfCache;
/** 清除缓存文件 */
+ (void)clearCacheFiles;

/** 获取app版本号 */
+ (NSString *)getAppVersion;

@end
