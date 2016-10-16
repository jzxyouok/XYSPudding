//
//  PDPropCatogryModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDPropGroodsListModel.h"

@implementation PDPropGroodsListModel

+ (NSDictionary *)specialClasses
{
    return @{@"result" : @"PDPropGroodsListResultModel"};
}

@end

@implementation PDPropGroodsListResultModel

+ (NSDictionary *)specialClasses
{
    return @{@"list" : @"PDPropGroodsListResultListModel"};
}

@end


@implementation PDPropGroodsListResultListModel

+ (NSDictionary *)specialClasses
{
    return @{@"image" : @"PDImageModel",
             @"iosImage" : @"PDImageModel",
             @"square" : @"PDImageModel"};
}

@end


@implementation PDImageModel

@end



