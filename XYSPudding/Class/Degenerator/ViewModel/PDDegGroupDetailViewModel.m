//
//  PDDegSingleGroupViewModel.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/14.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupDetailViewModel.h"
#import "PDDegNetwork.h"
#import "PDDegGroupDetailModel.h"

@interface PDDegGroupDetailViewModel ()

@property (nonatomic, strong) PDDegGroupDetailModel *model;
@end
@implementation PDDegGroupDetailViewModel

/** 传入小组id，通过id来实现数据获取 */
- (instancetype)initWithGrupID:(NSString *)id_
{
    if (self = [super init])
    {
        _id_ = id_;
    }
    return self;
}


- (void)getDataWithCompletionHandler:(void (^)(NSError *))completionHandler
{
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    self.dataTask = [PDDegNetwork loadGroupDetailDataWithID:_id_
                                          completionHandler:^(id model, NSError *error)
    {
        if (!error)
        {
            _model = model;
        }
        completionHandler(error);
    }];
}

/** 图标 */
- (NSURL *)iconURL
{
    return [NSURL URLWithString:_model.icon.url];
}
/** 成员数目 */
- (NSInteger)numberOfMembers
{
    return _model.memberCount;
}
/** 今日主题数目 */
- (NSInteger)numberOfTodatTopics
{
    return _model.todayTopicCount;
}
/** 组长名称 */
- (NSString *)creatorName
{
    return _model.creator.nickname;
}
/** 副组长名称 */
- (NSArray<NSString *> *)viceOwnerNames
{
    NSMutableArray *tempM = [NSMutableArray array];
    
    if (_model.viceOwners && _model.viceOwners.count>0)
    {
        for (PDUserModel *memberModel in _model.viceOwners)
        {
            [tempM addObject:memberModel.nickname];
        }
    }
    return [tempM copy];
}
@end
