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
    return @{@"ownerObject" : @"Ownerobject",
             @"relatedObject" : @"Relatedobject"};
}

@end

@implementation Ownerobject

+ (NSDictionary *)specialClasses
{
    return @{@"background" : @"Background",
             @"avatar" : @"Avatar"};
}

@end

@implementation Relatedobject

+ (NSDictionary *)specialClasses
{
    return @{@"group" : @"Group",
             @"images" : @"Images"};
}

@end


@implementation Avatar

@end


@implementation Background

@end



@implementation Group

+ (NSDictionary *)specialClasses
{
    return @{@"background" : @"Background"};
}

@end


@implementation Icon

@end



@implementation Images

@end


