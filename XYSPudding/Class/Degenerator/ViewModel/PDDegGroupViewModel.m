//
//  PDDegGroupViewModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupViewModel.h"
#import "PDDegNetwork.h"
#import "PDDegGroupModel.h"

@implementation PDDegGroupViewModel

/** 刷新数据 */
- (void)refreshDataWithCompletionHandler:(void (^)(NSError *))completionHandler
{
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    self.dataTask = [PDDegNetwork loadGroupDataWithCompletionHandler:^(id model, NSError *error)
                     {
                         self.datas = [(NSArray *)model copy];
                         
                         completionHandler(error);
                     }];

}

- (PDDegGroupModel *)getGroupModelWithIndex:(NSInteger)index
{
    return self.datas[index];
}


/** 分组数目 */
- (NSInteger)groupNumber
{
    return self.datas.count;
}
/** 分组展示图片URL */
- (NSURL *)imageURLWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getGroupModelWithIndex:index].icon.url];
}
/** 分组名称 */
- (NSString *)nameWithIndex:(NSInteger)index
{
    return [self getGroupModelWithIndex:index].name;
}

/** 分组详情展示背景图URL */
- (NSURL *)backgroundImageURLWithIndex:(NSInteger)index
{
    return [NSURL URLWithString:[self getGroupModelWithIndex:index].background.url];
}
@end
