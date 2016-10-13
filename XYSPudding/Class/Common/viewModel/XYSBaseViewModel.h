/*!
 *  MVVM模式的ViewModel专用基类
 *
 *  获取model数据
 *
 *  Created by XYS on 16/9/1
 */

#import "XYSBaseViewModelDelegate.h"

@interface XYSBaseViewModel : NSObject<XYSBaseViewModelDelegate>
/*!
 *  记录当前的网络数据传输任务
 */
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
/*!
 *  记录当前的数据请求页面索引值
 */
@property (nonatomic, assign) NSInteger page;
/*!
 *  记录当前数据更新时机
 */
@property (nonatomic, copy) NSString *time;
/*!
 *  记录模型数据对象
 */
@property (nonatomic, copy) NSMutableArray *datas;
/*!
 *  模型数据对象数目
 */
@property (nonatomic, assign) NSInteger countOfDatas;

/*!
 *  撤销当前网络请求任务
 */
- (void)cancelTask;
/*!
 *  暂停当前网络请求任务
 */
- (void)suspendTask;
/*!
 *  开启当前网络请求任务
 */
- (void)resumeTask;

@end
