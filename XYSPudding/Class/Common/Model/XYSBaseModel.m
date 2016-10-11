#import "XYSBaseModel.h"
#import <objc/runtime.h>

@implementation XYSBaseModel

#pragma mark - 解析方法

/** 万能数据解析方法 */
+ (id)parse:(id)responseObject
{
    id obj = responseObject;
    /** 字典解析 */
    if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        obj = [self parseDictionary:responseObject];
        return obj;
    }
    /** 数组解析 */
    if ([responseObject isKindOfClass:[NSArray class]])
    {
        obj = [self parseArray:responseObject];
        return obj;
    }
    /** 解析二进制类型的JSON数据(没有JSON序列化的数据) */
    if ([responseObject isKindOfClass:[NSData class]])
    {
        NSError *error = nil;
        id data = [NSJSONSerialization JSONObjectWithData:responseObject
                                                  options:NSJSONReadingMutableContainers |
                   NSJSONReadingMutableLeaves |
                   NSJSONReadingAllowFragments
                                                    error:&error]; //JSON序列化
        
        BOOL success = [responseObject isKindOfClass:[NSDictionary class]] ||
        [responseObject isKindOfClass:[NSArray class]] ||
        [responseObject isKindOfClass:[NSString class]]; //判断序列化出的数据类型是否正常
        
        NSAssert(!error || success, @"JSON数据序列化出现问题", __FUNCTION__); //崩溃程序，设置不崩溃条件
        
        if ([data isKindOfClass:[NSData class]]) //未解析出数据（数据类型不变）
        {
            return obj;
        }
        else
        {
            return [self parse:data];
        }
    }
    
    return obj;
}

/** 字典类型数据解析 */
+ (id)parseDictionary:(NSDictionary *)responseObject
{
    id obj1 = [self new];
    
    NSDictionary *specialProperties = [self specialProperties]; //获取用户设置的关键字属性（jsonKey : property）
    NSDictionary *specialClasses = [self specialClasses]; //获取用户设置的特殊类属性(jsonKey : class)
    
    [responseObject enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                                        id  _Nonnull obj,
                                                        BOOL * _Nonnull stop)
     {
         if ([specialProperties objectForKey:key]) //替换key
         {
             key = specialProperties[key];
         }
         
         if ([specialClasses objectForKey:key]) //创建类对象
         {
             Class class = NSClassFromString(specialClasses[key]);
             obj = [class parse:obj]; //解析
         }
         
         [obj1 setValue:obj forKey:key]; //赋值
     }];
    
    return obj1;
}

/** 数组类型数据解析 */
+ (NSArray *)parseArray:(NSArray *)responseObject
{
    NSMutableArray *arr = [NSMutableArray array];
    
    [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                 NSUInteger idx,
                                                 BOOL * _Nonnull stop)
     {
         id obj1 = [self parseDictionary:obj];
         [arr addObject:obj1];
     }];
    
    return [arr copy];
}

#pragma mark - 解析的特殊处理（属性、属性类型）

/** 解析自定义属性名的属性, 子类通过重写该方法，以键值对的形式在字典中增加自定义的属性名（解析key : 自定义属性名）*/
+ (NSDictionary *)specialProperties
{
    return nil;
}

/** 解析自定义类的类型 （属性名 : 自定义类的类名）*/
+ (NSDictionary *)specialClasses
{
    return nil;
}

/** 重写该方法，防止对空key赋值出现的crash现象 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

#pragma mark - NSCoding协议方法（归档、解档）

/** 归档操作(仅对象属性编码) */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSArray *allPropertyNames = [self AllPropertyNames];
    
    for (NSString *propertyName in allPropertyNames)
    {
        id value =  [self valueForKey:propertyName];
        [aCoder encodeObject:value forKey:propertyName];
    }
}

/**  解档操作(仅对象属性解码) */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        NSArray *allPropertyNames = [self AllPropertyNames];
        for (NSString *propertyName in allPropertyNames)
        {
            id value =  [[aDecoder decodeObjectForKey:propertyName] copy];
            [self setValue:value forKey:propertyName];
        }
    }
    return self;
}

/** 获取类的所有属性名集和 */
- (NSArray *)AllPropertyNames
{
    /** 通过objc_property_t获取本对象属性列表中的首个属性地址 */
    unsigned int numberOfProperties; //记录属性个数
    objc_property_t *properties = class_copyPropertyList([self class], &numberOfProperties);
    
    /** objc_property_t属性类型名转换为UTF8字符串，存入数组中*/
    NSMutableArray *tempM = [NSMutableArray array];
    for (int i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        [tempM addObject:name];
    }
    return [tempM copy];
}

#pragma mark -  NSCopying协议方法

/** 自定义copy方法，仅仅拷贝属性内容，对方法内容不作处理 */
- (id)copyWithZone:(NSZone *)zone
{
    id obj = [[self class] new];
    NSArray *allPropertyNames = [self AllPropertyNames];
    for (NSString *propertyName in allPropertyNames)
    {
        id value = [self valueForKey:propertyName];
        [obj setValue:value forKey:propertyName];
    }
    return obj;
}

/** 自定义打印的描述信息 */
- (NSString *)description
{
    NSString *desc = nil;
    
    desc = [NSString stringWithFormat:@"%@<%p>: {", NSStringFromClass([self class]), self];
    
    NSArray *allPropertyNames = [self AllPropertyNames];
    for (NSString *propertyName in allPropertyNames)
    {
        id value = [self valueForKey:propertyName];
        desc = [desc stringByAppendingFormat:@"\n\t%@: %@",propertyName, value];
    }
    desc = [desc stringByAppendingString:@"\n}"];
    
    return desc;
}
@end
