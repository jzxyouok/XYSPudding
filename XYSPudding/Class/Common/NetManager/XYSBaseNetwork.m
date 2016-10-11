#import "XYSBaseNetwork.h"
#import "AFNetworking.h"

@implementation XYSBaseNetwork

#pragma mark - AF HTTP单例

/** 多线程线程单例模式创建AFNetworking的HTTP数据请求管理对象 */
+ (AFHTTPSessionManager *)manager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t once;
    void(^onceTask)() = ^
    {
        if (!manager)
        {
            manager = [AFHTTPSessionManager manager];
            NSSet *sets = [NSSet setWithArray:@[@"text/html", @"application/json", @"text/json", @"text/javascript"]]; //数据解析类型
            manager.responseSerializer.acceptableContentTypes = sets;
        }
    };
    dispatch_once(&once, onceTask);
    
    return manager;
}

#pragma mark - 网络数据请求

/** NSURLSessionDataTask方式请求网络数据 */
+ (id)    getPath:(NSString *)path
       parameters:(NSDictionary *)params
completionHandler:(void(^)(id responseObject, NSError *error))completionHandler
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; //开启状态栏网络指示器
    
    if (params && [params allKeys].count>0) //配置请求地址和请求参数
    {
        NSMutableString *requestPath = [NSMutableString new];
        [requestPath appendString:path];
        [requestPath appendString:@"?"];
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,
                                                    id  _Nonnull obj,
                                                    BOOL * _Nonnull stop)
         {
             NSString *str = [NSString stringWithFormat:@"%@=%@&", key, obj];
             [requestPath appendString:str];
         }];
        [requestPath deleteCharactersInRange:NSMakeRange(requestPath.length-1, 1)]; //除去多余的&
        
        path = [requestPath mutableCopy];
    }
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:path]
                                                                 completionHandler:^(NSData * _Nullable data,
                                                                                     NSURLResponse * _Nullable response,
                                                                                     NSError * _Nullable error)
                                      {
                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //关闭状态栏网络指示器
                                          if (error)
                                          {
                                              dispatch_async(dispatch_get_main_queue(), ^
                                                             {
                                                                 DDLogError(@"NSURL:数据请求失败！%@", error); //打印错误信息
                                                                 completionHandler(nil, error); //数据请求失败
                                                             });
                                          }
                                          else
                                          {
                                              id obj = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers |
                                                        NSJSONReadingMutableLeaves |
                                                        NSJSONReadingAllowFragments
                                                                                         error:&error]; //JSON数据序列化
                                              if (error)
                                              {
                                                  dispatch_async(dispatch_get_main_queue(), ^
                                                                 {
                                                                     DDLogError(@"NSURL:数据JSON序列化失败！%@", error); //打印错误信息
                                                                     completionHandler(nil, error); //序列化失败
                                                                 });
                                              }
                                              else
                                              {
                                                  dispatch_async(dispatch_get_main_queue(), ^
                                                                 {
                                                                     completionHandler(obj, nil); //序列化成功
                                                                 });
                                              }
                                          }
                                      }];
    
    [dataTask resume]; //开启网络数据请求任务
    
    return dataTask;
}

/** AFNetworking方式Get请求网络数据  */
+ (id) getPathA:(NSString *)path
     parameters:(NSDictionary *)params
        timeout:(NSTimeInterval)timeout
completionHandler:(void(^)(id responseObject, NSError *error))completionHandler
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; //开启状态栏网络指示器
    
    AFHTTPSessionManager *httpManager = [self manager]; //获取http管理对象
    httpManager.requestSerializer.timeoutInterval = timeout; //限制请求时间
    
    return [httpManager GET:path
                 parameters:params
                   progress:nil
                    success:^(NSURLSessionDataTask * _Nonnull task,
                              id  _Nullable responseObject) //请求成功
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; //关闭指示器
                completionHandler(responseObject, nil);
            }
                    failure:^(NSURLSessionDataTask * _Nullable task,
                              NSError * _Nonnull error)  //请求失败
            {
                DDLogError(@"AF(GET):数据请求失败！%@", error); //打印错误信息
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; //关闭指示器
                completionHandler(nil, error);
            }];
}

/** AFNetworking方式Post请求网络数据 */
+ (id)  postPathA:(NSString *)path
       parameters:(NSDictionary *)params
          timeout:(NSTimeInterval)timeout
completionHandler:(void(^)(id responseObject, NSError *error))completionHandler
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; //开启状态栏网络指示器
    
    AFHTTPSessionManager *httpManager = [self manager]; //获取http管理对象
    httpManager.requestSerializer.timeoutInterval = timeout; //限制请求时间
    
    return [httpManager POST:path
                  parameters:params
                    progress:^(NSProgress * _Nonnull uploadProgress)
            {
                
            }
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; //关闭指示器
                completionHandler(responseObject, nil);
            }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                DDLogError(@"AF:数据请求失败！%@", error); //打印错误信息
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; //关闭指示器
                completionHandler(nil, error);
            }];
}




#pragma mark - 本地数据请求

+ (void)getLocalPath:(NSString *)path completionHandler:(void(^)(id responseObject, NSError *error))completionHandler
{
    NSError *error = nil; //记录错误内容
    id obj = nil; //记录获取的数据
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) //本地路径是否存在
    {
        if ((obj = [NSArray arrayWithContentsOfFile:path]))//数组root的plist文件
        {
            completionHandler(obj, nil);
        }
        else if ((obj = [NSDictionary dictionaryWithContentsOfFile:path]))//字典root的plist文件
        {
            completionHandler(obj, nil);
        }
        else //本地JSON数据
        {
            obj = [NSJSONSerialization JSONObjectWithData:  [NSData dataWithContentsOfFile:path]
                                                  options:  NSJSONReadingMutableContainers |
                   NSJSONReadingMutableLeaves |
                   NSJSONReadingAllowFragments
                                                    error:  &error]; //JSON数据序列化
            if (error)
            {
                completionHandler(nil, error); //序列化失败
            }
            else
            {
                completionHandler(obj, nil); //序列化成功
            }
        }
    }
    else
    {
        error = [NSError errorWithDomain:@"本地路径错误" code:-1 userInfo:nil];
        completionHandler(nil, error);
    }
}


@end
