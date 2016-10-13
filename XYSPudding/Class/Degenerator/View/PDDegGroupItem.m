//
//  PDDegGroupItem.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/12.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDDegGroupItem.h"

@implementation PDDegGroupItem


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.imageView.layer.cornerRadius = 5;
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self setTitleColor:[UIColor lightGrayColor]
               forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 15;
    self.imageView.y = 0;
    self.imageView.width = self.width-30;
    self.imageView.height = self.height-30;
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 5;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height-self.imageView.height-5;
}
@end
