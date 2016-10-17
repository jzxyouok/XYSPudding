//
//  PDDegImageModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegImageListModel.h"

#pragma mark - 第一层

@implementation PDDegImageListModel

+ (NSDictionary *)specialClasses
{
    return @{@"image" : @"PDImageModel",
             @"user" : @"PDUserModel"};
}

@end

