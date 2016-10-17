//
//  PDResultModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDReceiveModel.h"

@implementation PDReceiveModel

+ (NSDictionary *)specialClasses
{
    return @{@"result" : @"PDResultModel"};
}

@end

@implementation PDResultModel

+ (NSDictionary *)specialProperties
{
    return @{@"list" : @"goodsList",
             @"animes" : @"animeList"};
}

+ (NSDictionary *)specialClasses
{
    return @{@"goodsList" : @"PDGoodsModel",
             @"animeList" : @"PDAnimeModel",
             @"eps" : @"PDEpsModel"};
}

@end
