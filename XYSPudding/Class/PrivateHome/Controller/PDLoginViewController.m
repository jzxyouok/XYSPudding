//
//  PDLoginViewController.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/11.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDLoginViewController.h"

@interface PDLoginViewController ()

/** 展示背景图 */
@property (nonatomic, strong) UIImageView *imageView;
/** 微博登录按钮 */
@property (nonatomic, strong) UIButton *wbButton;
/** QQ登录按钮 */
@property (nonatomic, strong) UIButton *qqButton;

@end

@implementation PDLoginViewController

/** 带导航栏的本控制器视图配置在自定义窗口，返回该窗口对象 */
+ (id)standardWindowWithController
{
    PDWindow *pWindow = [PDWindow standardWindow];
    pWindow.rootViewController = [PDLoginViewController new];
    return pWindow;
}

#pragma mark - getter

/** 展示背景图 */
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        [_imageView setImage:[UIImage imageNamed:@"login_bg_320x290_"]];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setClipsToBounds:YES];
        [_imageView setBackgroundColor:kBGDColor];
        [_imageView setTintColor:kRGBColor(200, 201, 205)];
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
    
    [self.view setBackgroundColor:kBGDColor];
    [self setTitle:@"登录"];
    [self addNavigationItems];
    [self viewDidLayoutMySubviews];
}

/** 添加导航栏标签 */
- (void)addNavigationItems
{
    [self addLeftItemWithStyle:PDLeftItemStyleBackImage
                                        clickHandler:^
     {
         [[PDWindow standardWindow] dismiss:YES]; //推出窗口
     }];
    [self addRightItemWithStyle:PDRightItemStyleTitle1
                                         clickHandler:^
     {
         DDLogInfo(@"用户协议");
     }];
}

/** 自定义布局 */
- (void)viewDidLayoutMySubviews
{
    /** 背景图 */
    [self.view addSubview:self.imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.mas_equalTo(0);
         make.width.mas_equalTo(350*kScale);
         make.height.mas_equalTo(350*kScale);
     }];
    
    /** 微博登录按钮 */
    [self.view addSubview:self.wbButton];
    [_wbButton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(self.view.mas_centerX).mas_offset(-135*kScale-5);
         make.top.mas_equalTo(_imageView.mas_bottom).mas_equalTo(30*kScale);
         make.width.mas_equalTo(135*kScale);
         make.height.mas_equalTo(50*kScale);
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

/** 重布局 */
kLayoutView

@end
