//
//  PDDegGroupTopicListModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/14.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupTopicListModel.h"

@implementation PDDegGroupTopicListModel

+ (NSDictionary *)specialClasses
{
    return @{@"activity" : @"PDDegGroupTopicListActivityModel",
             @"images" : @"PDImageModel",
             @"user" : @"PDUserModel"};
}

@end

@implementation PDDegGroupTopicListActivityModel

@end


