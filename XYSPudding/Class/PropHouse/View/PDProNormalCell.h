//
//  PDProNormalCell.h
//  XYSPudding
//
//  Created by 徐玉珊 on 2016/10/16.
//  Copyright © 2016年 XYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDProNormalCell : UICollectionViewCell

/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 图片资源本地名称 */
@property (nonatomic, strong) NSString *imageName;
/** 描述信息 */
@property (nonatomic, strong) NSString *describe;

@end
