//
//  PDDegGroupTopicListController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/13.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupTopicListController.h"
#import "PDWindow.h"
#import "UIViewController+NavigationItem.h"

@interface PDDegGroupTopicListController ()

@end

@implementation PDDegGroupTopicListController

/** 自定义视图配置的控制器 */
+ (id)defaultControllerWithBgdImageURL:(NSURL *)bgdImageURL
{
    PDWindow *pWindow = [PDWindow new];
    PDDegGroupTopicListController *topicListVC = [PDDegGroupTopicListController new];
    topicListVC.bgdImageURL = bgdImageURL;
    pWindow.rootViewController = topicListVC;
    __block PDWindow *blockObj = pWindow;
    /** 为导航栏添加左侧标签 */
    [pWindow.rootViewController addLeftItemWithStyle:PDLeftItemStyleBackImage
                                   clickHandler:^
     {
         [blockObj viewWillDisappear:YES];
     }];
    
    return pWindow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addHeadView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 头部视图 */
- (void)addHeadView
{
    UIImageView *headView = [UIImageView viewWithFrame:CGRectMake(0, 0, 0, 250*kScreenWidth/1024)];
    [headView setImageWithURL:_bgdImageURL];
    [headView setContentMode:UIViewContentModeScaleAspectFill];
    [headView setClipsToBounds:YES];
    [self.tableView setTableHeaderView:headView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Cell"];
    }
    
    return cell;
}

/** 重布局 */
kLayoutView

@end
