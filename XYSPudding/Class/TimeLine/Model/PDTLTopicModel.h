//
//  PDTLTopicModel.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "XYSBaseModel.h"



@class Ownerobject,Avatar,Background,Relatedobject,Group,Icon,Background,Images;

@interface PDTLTopicModel : XYSBaseModel

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, strong) Ownerobject *ownerObject;

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger postedTime;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) Relatedobject *relatedObject;

@property (nonatomic, assign) NSInteger voteCount;

@end

@interface Ownerobject : XYSBaseModel

@property (nonatomic, strong) NSArray<NSString *> *authorityDes;

@property (nonatomic, assign) CGFloat coinCount;

@property (nonatomic, assign) NSInteger birthday;

@property (nonatomic, assign) NSInteger followingCount;

@property (nonatomic, assign) BOOL strangerChatEnabled;

@property (nonatomic, strong) NSArray<NSString *> *authorities;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger picCount;

@property (nonatomic, strong) NSArray *roleIntro;

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, strong) Background *background;

@property (nonatomic, assign) NSInteger epCount;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, assign) NSInteger topicCount;

@property (nonatomic, assign) NSInteger followingBoardCount;

@property (nonatomic, assign) BOOL blocked;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, assign) BOOL isAdmin;

@property (nonatomic, strong) NSArray *roles;

@property (nonatomic, assign) NSInteger audioCount;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, strong) Avatar *avatar;

@property (nonatomic, assign) BOOL rongCloudActivated;

@property (nonatomic, assign) NSInteger followerCount;

@property (nonatomic, assign) NSInteger epPlayCount;

@property (nonatomic, assign) NSInteger boardCount;

@end

@interface Avatar : XYSBaseModel

@property (nonatomic, copy) NSString *url;

@end

@interface Background : XYSBaseModel

@property (nonatomic, copy) NSString *url;

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

@property (nonatomic, strong) NSArray<Images *> *images;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, copy) NSString *content;

@end

@interface Group : XYSBaseModel

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, assign) NSInteger topicCount;

@property (nonatomic, assign) NSInteger memberCount;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, strong) Background *background;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Icon *icon;

@end

@interface Icon : XYSBaseModel

@property (nonatomic, copy) NSString *url;

@end


@interface Images : XYSBaseModel

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger height;

@end

