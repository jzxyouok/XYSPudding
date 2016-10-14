//
//  PDPrivSetController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/13.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDPrivSetController.h"
#import "PDPrivSetCell.h"
#import "NSObject+XYSFactory.h"

@interface PDPrivSetController ()

@end

@implementation PDPrivSetController

/** 带导航栏的本控制器视图配置在自定义窗口，返回该窗口对象 */
+ (id)standardWindowWithController
{
    PDWindow *pWindow = [PDWindow standardWindow];
    pWindow.rootViewController = [[PDPrivSetController alloc] initWithStyle:UITableViewStyleGrouped];
    return pWindow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    [self addNavigationItems];

    [self.tableView setBackgroundColor:kBGDColor];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setContentInset:UIEdgeInsetsMake(-30, 0, 0, 0)];
    [self.tableView registerClass:[PDPrivSetCell class]
           forCellReuseIdentifier:@"switchCell"];
    [self addFooterView];
}

/** 添加导航栏标签 */
- (void)addNavigationItems
{
    [self addLeftItemWithStyle:PDLeftItemStyleBackImage
                                        clickHandler:^
     {
         [[PDWindow standardWindow] dismiss:YES]; //推出窗口
     }];
}

/** 添加底部视图(显示版本号) */
- (void)addFooterView
{
    UILabel *footerLabel = [UILabel viewWithFrame:CGRectMake(0, 0, 0, 17*kScale)];
    [footerLabel setTextColor:[UIColor lightGrayColor]];
    [footerLabel setText:[NSString stringWithFormat:@"v%@", [NSObject getAppVersion]]];
    [footerLabel setTextAlignment:NSTextAlignmentCenter];
    [footerLabel setFont:[UIFont systemFontOfSize:17*kScale]];
    [self.tableView setTableFooterView:footerLabel];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0 && indexPath.row != 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:@"normalCell"];
        }
    }
    
    if (indexPath.section == 0 && indexPath.row == 2)
    {
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%.1lfMB", [NSObject getSizeOfCache]]];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14*kScale]];
    }
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:13*kScale]];
    [cell.textLabel setTextColor:kTextColor];
    [cell.textLabel setText:[self titles][indexPath.row + indexPath.section*3]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*kScale;
}

/** 清除cell侧边间距 */
kRemoveCellSideSpace

/** 分组头部视图高度 */
- (CGFloat)    tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 0;
}

/** 点击事件 */
- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 2)
    {
        [self alertForClearImageCache];
    }
}

/** 清空图片缓存的提示框 */
- (void)alertForClearImageCache
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"真的要清空图片缓存喵><"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       
                                   }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action)
                               {
                                   [NSObject clearCacheFiles];
                               }];
    [alertController addAction:cancleAction];
    [alertController addAction:okAction];
    [alertController.view.layer setCornerRadius:20];
    [alertController.view setClipsToBounds:YES];
    [alertController.view.layer setBorderWidth:1];
    [alertController.view setBackgroundColor:[UIColor whiteColor]];
    [alertController.view.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self presentViewController:alertController
                       animated:YES
                     completion:^
    {
        [alertController.view.layer setBorderWidth:0];
        [alertController.view setBackgroundColor:[UIColor clearColor]];
    }];//显示警告框
}




/** cell标题数据 */
- (NSArray *)titles
{
    return @[ @"播放完毕提醒清除缓存", @"清除缓存", @"清空图片缓存", @"建议反馈", @"动画投递", @"加入我们", @"用户协议", @"把布丁动画推荐给小伙伴", @"给布丁动画打分"];
}

/** 重布局 */
kLayoutView

@end
