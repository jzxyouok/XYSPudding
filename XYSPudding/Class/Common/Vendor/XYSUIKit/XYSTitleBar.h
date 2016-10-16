/*!
 *  名称：XYSTitleBar
 *
 *  作用：作为标题栏，展示标题标签
 *
 *  布局需要Masonry支持 https://github.com/SnapKit/Masonry
 *
 *  Created by XYS on 2016/9/30.
 */

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface XYSTitleBar : UIView
/**
 *  工厂方法实例化对象
 */
+ (id)barWithTitles:(NSArray *)titles;
/**
 *  记录标签名称
 */
@property (nonatomic, readonly) NSArray *titles;

/**
 *  头部间距, 默认0
 */
@property (nonatomic, assign) CGFloat headSpace;
/**
 *  尾部间距, 默认0
 */
@property (nonatomic, assign) CGFloat trailSpace;
/**
 *  标题标签的大小, 默认(60,35)
 */
@property (nonatomic, assign) CGSize size;
/**
 *  标签间距, 默认0
 */
@property (nonatomic, assign) CGFloat space;

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
 *  记录选中的标签索引(默认0), 修改选中的标签索引,
 */
@property (nonatomic, assign) NSInteger selectedItem;
/**
 *  自动滑动，默认为NO
 */
@property (nonatomic, assign) BOOL autoScroll;
/**
 *  显示底线，默认显示底线
 */
@property (nonatomic, assign, getter=isShowLine) BOOL showLine;
/**
 *  底线颜色，默认蓝色
 */
@property (nonatomic, strong) UIColor *lineColor;
@end

/**
 *  标签点击回调事件处理
 */
typedef void(^ClickHandler)(NSInteger index);
@interface XYSTitleBar ()
@property (nonatomic, strong) ClickHandler clickHandler;
- (void)clickHandler:(ClickHandler)handler;
@end
