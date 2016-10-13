//
//  PDDegImageModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegImageModel.h"

#pragma mark - 第一层

@implementation PDDegImageModel

+ (NSDictionary *)specialClasses
{
    return @{@"image" : @"PDDegImageImageModel", @"user" : @"PDDegImageUserModel"};
}

@end

#pragma mark - 第二层

@implementation PDDegImageImageModel

@end


@implementation PDDegImageUserModel

+ (NSDictionary *)specialClasses
{
    return @{@"avatar" : @"PDDegImageUserAvatarModel", @"background" : @"PDDegImageUserBackgroundModel"};
}

@end

#pragma mark - 第三层

@implementation PDDegImageUserAvatarModel

@end


@implementation PDDegImageUserBackgroundModel

@end


