//
//  PDUserModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/14.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDUserModel.h"

@implementation PDUserModel

+ (NSDictionary *)specialClasses
{
    return @{@"avatar" : @"PDImageModel",
             @"background" : @"PDImageModel",
             @"icon" : @"PDImageModel"};
}

@end