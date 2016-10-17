//
//  PDAnimeGroupListModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDAnimeGroupListModel.h"

@implementation PDAnimeGroupListModel

+ (NSDictionary *)specialClasses
{
    return @{@"image" : @"PDImageModel",
             @"itemCount" : @"Itemcount",
             @"items" : @"Items"};
}

@end


@implementation Itemcount

@end


@implementation Items

+ (NSDictionary *)specialClasses
{
    return @{@"item" : @"PDAnimeModel"};
}

@end

