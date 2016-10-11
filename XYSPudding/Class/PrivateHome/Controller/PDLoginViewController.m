//
//  PDLoginViewController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDLoginViewController.h"
#import "UIViewController+NavigationItem.h"
#import "PDShowViewController.h"

@interface PDLoginViewController ()


@end

@implementation PDLoginViewController

/** 自定义视图配置的控制器 */
+ (id)defaultController
{
    PDShowViewController *showVC = [PDShowViewController new];
    showVC.viewController = [PDLoginViewController new];
    
    __block PDShowViewController *blockObj = showVC;
    [showVC.viewController addLeftItemWithStyle:PDLeftItemStyleBackImage
             clickHandler:^
     {
         [blockObj viewWillDisappear:YES];
     }];
    [showVC.viewController addRightItemWithStyle:PDRightItemStyleTitle1
                                    clickHandler:^
    {
        DDLogInfo(@"用户协议");
    }];
    
    return showVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:kBGDColor];
    [self.view.layer setCornerRadius:10];
    self.title = @"登录";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
