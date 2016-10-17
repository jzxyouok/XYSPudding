//
//  PDDegGroupTopicHeadModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/14.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupDetailModel.h"

@implementation PDDegGroupDetailModel

+ (NSDictionary *)specialClasses
{
    return @{@"creator" : @"PDUserModel",
             @"viceOwners" : @"PDUserModel",
             @"icon" : @"PDImageModel"};
}

@end


