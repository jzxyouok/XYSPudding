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

/** 展示背景图 */
@property (nonatomic, strong) UIImageView *imageView;
/** 微博登录按钮 */
@property (nonatomic, strong) UIButton *wbButton;
/** QQ登录按钮 */
@property (nonatomic, strong) UIButton *qqButton;

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

#pragma mark - getter

/** 展示背景图 */
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        [_imageView setImage:[UIImage imageNamed:@"login_bg_320x290_"]];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        _imageView.backgroundColor = [UIColor whiteColor];//设置背景色
    }
    return _imageView;
}

/** 微博登录按钮 */
- (UIButton *)wbButton
{
    if (!_wbButton)
    {
        _wbButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wbButton normalImage:[UIImage imageNamed:@"login_btn_weibo_normal_135x50_"]];
        [_wbButton bk_addEventHandler:^(id sender)
        {
           NSLog(@"微博登录");
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _wbButton;
}
/** QQ登录按钮 */
- (UIButton *)qqButton
{
    if (!_qqButton)
    {
        _qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqButton normalImage:[UIImage imageNamed:@"login_btn_qq_normal_135x50_"]];
        [_wbButton bk_addEventHandler:^(id sender)
         {
             NSLog(@"QQ登录");
         } forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqButton;
}

#pragma mark - 视图配置

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.view setBackgroundColor:self.view.backgroundColor];

    self.title = @"登录";
    
    [self viewDidLayoutMySubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/** 自定义布局 */
- (void)viewDidLayoutMySubviews
{
    /** 背景图 */
    [self.view addSubview:self.imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.left.mas_equalTo(100*kScreenWidth/1024.0);
         make.bottom.right.mas_equalTo(-100*kScreenWidth/1024.0);
         
     }];
    
    /** 微博登录按钮 */
    [self.view addSubview:self.wbButton];
    [_wbButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(self.view.mas_centerX).mas_offset(-135*kScreenWidth/1024.0-5);
         make.bottom.mas_equalTo(-10);
         make.size.mas_equalTo(CGSizeMake(135*kScreenWidth/1024.0, 50*kScreenWidth/1024.0));
         
     }];
    
    /** qq登录按钮 */
    [self.view addSubview:self.qqButton];
    [_qqButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_wbButton.mas_right).mas_equalTo(10);
         make.bottomMargin.mas_equalTo(_wbButton);
         make.size.mas_equalTo(_wbButton);
     }];
}

@end
