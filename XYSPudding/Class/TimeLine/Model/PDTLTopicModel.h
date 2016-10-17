//
//  PDTLTopicModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseModel.h"
#import "PDUserModel.h"

@class Relatedobject,Subject, Group;

@interface PDTLTopicModel : XYSBaseModel

/** id标识 */
@property (nonatomic, copy) NSString *_id;
/** 回复数目 */
@property (nonatomic, assign) NSInteger replyCount;
/** 状态码 */
@property (nonatomic, assign) NSInteger status;
/** 发布时间 */
@property (nonatomic, assign) NSInteger postedTime;
/** 主题类型 */
@property (nonatomic, assign) NSInteger type;
/** 收藏数目 */
@property (nonatomic, assign) NSInteger voteCount;
/** 相关对象 */
@property (nonatomic, strong) Relatedobject *relatedObject;
/** 用户对象 */
@property (nonatomic, strong) PDUserModel *ownerObject;

@property (nonatomic, strong) Subject *subject;

@end


@interface Relatedobject : XYSBaseModel

@property (nonatomic, assign) NSInteger replyTime;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger insertedTime;

@property (nonatomic, assign) NSInteger voteCount;

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, copy) NSString *activityId;

@property (nonatomic, assign) NSInteger hot;

@property (nonatomic, strong) Group *group;

@property (nonatomic, assign) BOOL stick;

@property (nonatomic, strong) NSArray<PDImageModel *> *images;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) Subject *subject;
@end


@interface Subject : XYSBaseModel

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger followCount;

@property (nonatomic, assign) NSInteger postCount;

@property (nonatomic, strong) PDImageModel *icon;

@end


@interface Group : XYSBaseModel

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, assign) NSInteger topicCount;

@property (nonatomic, assign) NSInteger memberCount;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, strong) PDImageModel *background;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) PDImageModel *icon;

@end


