//
//  NSObject+Factory.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "NSObject+Factory.h"

@implementation NSObject (Factory)

/** 显示无网络提示框 */
- (void)showAlertForDisconnectNetwork
{
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD showImage:[UIImage imageNamed:@"alert_error_icon"] status:@"无网络连接"];
}

@end
