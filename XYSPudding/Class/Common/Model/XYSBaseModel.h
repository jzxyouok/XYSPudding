#import <Foundation/Foundation.h>

/*!
 *  简单的数据解析协议
 *
 *  作用：解析JSON序列化后的数据（数组、字典、字符串）
 *       支持解析未序列化的JSON二进制数据
 *       支持属性解档和归档
 *       支持对象属性拷贝
 *
 *  支持平台：IOS:5_0+ (5.0之前也可用，但不支持解析未序列化的JSON二进制数据)
 *
 *  Created by XYS on 16/9/1
 */
@protocol XYSBaseModelDelegate <NSObject>

@optional

#pragma mark - 解析方法
/*!
 *  万能解析数据方法(数组、字典、二进制Json数据), 特殊处理的数组可以重写该方法进行处理
 */
+ (id)parse:(id)responseObject;

#pragma mark - 解析的特殊处理
/*!
 *  解析自定义属性名的属性, 子类通过重写该方法，以键值对的形式在字典中增加自定义的属性名（解析key : 自定义属性名）
 */
+ (NSDictionary *)specialProperties;
/*!
 *  解析自定义类的对象 （属性名 : 自定义类的类名）
 */
+ (NSDictionary *)specialClasses;

@end

/*!
 *  简单的数据解析模型基类
 *
 *  Created by XYS on 16/9/1
 */
@interface XYSBaseModel : NSObject<XYSBaseModelDelegate, NSCoding, NSCopying>
/*!
 *  定义多个共同属性，添加其他的自定义方法...
 */
@end

