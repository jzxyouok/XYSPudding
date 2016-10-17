/**
 *  最近更新的数据模型
 */

#import "PDReceiveModel.h"
#import "PDImageModel.h"

@interface PDHPLatestModel : PDReceiveModel

@end


@interface PDEpsModel : XYSBaseModel

@property (nonatomic, assign) BOOL isMusic;

@property (nonatomic, strong) PDAnimeModel *anime;

@property (nonatomic, copy) NSString *animeImageUrl;

@property (nonatomic, assign) NSInteger serialId;

@property (nonatomic, assign) NSInteger insertedTime;

@property (nonatomic, copy) NSString *_id;

@property (nonatomic, assign) BOOL isFromAudio;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *animeId;

@property (nonatomic, assign) NSInteger coinCount;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, strong) PDImageModel *image;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, copy) NSString *animeName;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSArray *commentStamps;

@property (nonatomic, strong) NSArray<NSString *> *animeCategoryNames;

@end
