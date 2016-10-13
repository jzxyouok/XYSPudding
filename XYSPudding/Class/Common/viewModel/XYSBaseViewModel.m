#import "XYSBaseViewModel.h"

@implementation XYSBaseViewModel

#pragma mark - 网络任务

/** 撤销网络请求任务 */
- (void)cancelTask
{
    [_dataTask cancel];
    _dataTask = nil;
}
/** 暂停网络请求任务 */
- (void)suspendTask
{
    [_dataTask suspend];
}
/** 开启网络请求任务 */
- (void)resumeTask
{
    [self.dataTask resume];
}

#pragma mark - 其他

/** 数据数目 */
- (NSInteger)countOfDatas
{
    return _datas ? _datas.count : 0;
}

- (NSMutableArray *)datas
{
    if (!_datas)
    {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
@end
