/**
 *  名称：XYSTitleItem
 *
 *  作用：点击标签，文字出现缩放动画, 点击事件回调
 *
 *  注意：默认文字居中
 *
 *  Created by XYS on 2016/9/30.
 */

#import <UIKit/UIKit.h>

/** 缩放动画风格（中心点位置）*/
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

/** 修改normal状态的字体，默认大小为系统样式15号 */
@property (nonatomic, strong) UIFont *normalFont;
/** 修改selected状态的字体，默认大小为系统样式15号 */
@property (nonatomic, strong) UIFont *selectedFont;
/** 修改normal状态的字体颜色，默认为灰色 */
@property (nonatomic, strong) UIColor *normalColor;
/** 修改selected状态的字体颜色，默认为红色 */
@property (nonatomic, strong) UIColor *selectedColor;
/** 修改标签选中状态, 默认未选中(NO) */
@property (nonatomic, assign, getter=isSelected) BOOL selected;
/** 动画缩放比, 默认1.1 */
@property (nonatomic, assign) CGFloat scale;
/** 缩放动画的样式，默认以中点为基准缩放 */
@property (nonatomic, assign) XYSScaleStyle scaleStyle;
/** 修改标签是否可以动画，默认可以动画（YES）*/
@property (nonatomic, assign, getter=isCanScale) BOOL canScale;
/** 修改当前状态是否可以点击，默认可以点击（YES）*/
@property (nonatomic, assign, getter=isDisabled) BOOL disabled;

@end

/** 标签点击的回调事件代码块 */
typedef void(^ClickHandler)(NSInteger tag);
@interface XYSTitleItem()
@property (nonatomic, copy) ClickHandler clickHandler;
/** 用户通过调用此函数获取标签点击时回传的tag值 */
- (void)clickHandler:(ClickHandler)clickHandler;
@end