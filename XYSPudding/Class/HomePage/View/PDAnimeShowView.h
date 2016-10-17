//
//  PDAnimeShowView.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/17.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDAnimeShowView : UIView

/** 动画展示图片 */
@property (nonatomic, strong) UIImageView *imageView;
/** 总集数标签 */
@property (nonatomic, strong) UILabel *numberLabel;
/** 动画名称标签 */
@property (nonatomic, strong) UILabel *nameLabel;

@end
