/**
 *  名称：XYSTitleItem
 *
 *  作用：点击标签，文字出现缩放动画
 *
 *  注意：默认开启用户交互功能，文字居中
 *
 *  Created by XYS on 2016/9/30.
 */

#import <UIKit/UIKit.h>

/**
 *  缩放动画风格（中心点位置）
 */
typedef NS_ENUM(NSInteger, XYSScaleStyle)
{
    /** 中心点为基准*/
    XYSScaleStyleCenter = 0,
    /** 左上点为基准*/
    XYSScaleStyleLeftTop = 1,
    /** 左下点为基准*/
    XYSScaleStyleLeftBottom = 2,
    /** 右上点为基准*/
    XYSScaleStyleRightTop = 3,
    /** 右下点为基准*/
    XYSScaleStyleRightBottom = 4
};

@interface XYSTitleItem : UILabel
/**
 *  normal状态的字体，默认大小为系统样式15号
 */
@property (nonatomic, strong) UIFont *normalFont;
/**
 *  selected状态的字体，默认大小为系统样式16号
 */
@property (nonatomic, strong) UIFont *selectedFont;
/**
 *  normal状态的字体颜色，默认为黑色 (可动画)
 */
@property (nonatomic, strong) UIColor *normalColor;
/**
 *  selected状态的字体颜色，默认为红色 (可动画)
 */
@property (nonatomic, strong) UIColor *selectedColor;
/**
 *  记录标签选中状态, 修改标签选中状态
 */
@property (nonatomic, assign, getter=isSelected) BOOL selected;
/*!
 *  动画缩放比
 */
@property (nonatomic, assign) CGFloat scale;
/**
 *  缩放动画的样式，默认以中点为基准缩放
 */
@property (nonatomic, assign) XYSScaleStyle scaleStyle;
/**
 *  记录标签是否可以动画，默认可以动画
 */
@property (nonatomic, assign, getter=isCanScale) BOOL canScale;
/**
 *  是否可以点击
 */
@property (nonatomic, assign, getter=isDisabled) BOOL disabled;
@end

/**
 *  标签点击的回调事件
 */
typedef void(^ClickHandler_)(NSInteger index);
@interface XYSTitleItem()
@property (nonatomic, copy) ClickHandler_ clickHandler;
- (void)clickHandler:(ClickHandler_)clickHandler;
@end