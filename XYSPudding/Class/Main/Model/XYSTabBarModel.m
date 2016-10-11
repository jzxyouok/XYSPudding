#import "XYSTabBarModel.h"

@implementation XYSTabBarModel

/** 通过字典传入属性值，init对象 */
+ (instancetype)modelWithDictionary:(NSDictionary *)dic
{
    XYSTabBarModel *model = [XYSTabBarModel new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

/** 对象模型数组 */
+ (NSArray *)getModels
{
    NSMutableArray *tempM = [NSMutableArray array];
    
    NSArray *tabBarDatas = [self tabBarDatas];
    NSInteger count = tabBarDatas.count;
        for (NSInteger i = 0; i < count; i++)
    {
        [tempM addObject:[XYSTabBarModel modelWithDictionary:tabBarDatas[i]]];
    }
    
    return [tempM copy];
};

/** 选择栏数据构建 */
+ (NSArray *)tabBarDatas
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TabBarDatas"
                                                         ofType:@"plist"];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:filePath];
    
    return plistArray;
}

@end