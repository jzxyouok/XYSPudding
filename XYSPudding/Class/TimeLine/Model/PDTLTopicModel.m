//
//  PDTLTopicModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDTLTopicModel.h"

@implementation PDTLTopicModel

+ (NSDictionary *)specialClasses
{
    return @{@"ownerObject" : @"PDUserModel",
             @"relatedObject" : @"Relatedobject",
             @"subject" : @"Subject"};
}

@end

@implementation Relatedobject

+ (NSDictionary *)specialClasses
{
    return @{@"group" : @"Group",
             @"images" : @"PDImageModel",
             @"subject" : @"Subject"};
}

@end

@implementation Subject

@end

@implementation Group

+ (NSDictionary *)specialClasses
{
    return @{@"background" : @"PDImageModel"};
}

@end



