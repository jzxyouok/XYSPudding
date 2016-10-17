/**
 *  动画信息模型
 */

#import "XYSBaseModel.h"
#import "PDImageModel.h"

@interface PDAnimeModel : XYSBaseModel

@property (nonatomic, assign) NSInteger chatGroupCount;

@property (nonatomic, assign) NSInteger pushedEpNumber;

@property (nonatomic, assign) NSInteger relatedImageTopicCount;

@property (nonatomic, assign) NSInteger viewMode;

@property (nonatomic, strong) PDImageModel *image;

@property (nonatomic, assign) NSInteger relatedTopicCount;

@property (nonatomic, assign) NSInteger picCount;

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, assign) NSInteger onairEpNumber;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, assign) NSInteger displayPlayCount;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL isEpCollection;

@property (nonatomic, assign) NSInteger relatedVideoTopicCount;

@property (nonatomic, copy) NSString *onairRuleDescription;

@property (nonatomic, assign) NSInteger totalEpCount;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, assign) BOOL gambling;

@property (nonatomic, strong) PDImageModel *defaultEpImage;


@property (nonatomic, strong) NSArray<NSNumber *> *videoSources;

@property (nonatomic, strong) NSArray<NSString *> *categoryNames;

@property (nonatomic, strong) NSArray *relatedTags;

@property (nonatomic, strong) NSArray *directorNames;

@property (nonatomic, strong) NSArray *peripheryIds;

@property (nonatomic, strong) NSArray<NSString *> *seiyuNames;

@property (nonatomic, strong) NSArray *aliases;

@property (nonatomic, strong) NSArray *studios;

@property (nonatomic, strong) NSArray *scenaristNames;

@property (nonatomic, copy) NSString *tip;

@end
