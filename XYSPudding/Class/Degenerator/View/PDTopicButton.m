//
//  PDTopicButton.m
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/15.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import "PDTopicButton.h"

@implementation PDTopicButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self normalTitleColor:[UIColor lightGrayColor]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:13*kScale]];
        [self highlightBGDImage:[UIImage imageNamed:@"hilight"]];
    }
    return self;
}

/** 重布局 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    /** 调整图片视图 */
    self.imageView.width = 23*kScale;
    self.imageView.height = 23*kScale;
    self.imageView.positionX = self.selfCenterX-7*kScale;
    self.imageView.positionY = self.selfCenterY;
    
    /** 调整label */
    self.titleLabel.width = self.width;
    self.titleLabel.x = self.imageView.x + self.imageView.width;
    self.titleLabel.positionY = self.selfCenterY;
}

@end
