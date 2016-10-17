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

/** 唯一的工厂方法实例化对象 */
+ (id)barWithTitles:(NSArray *)titles;
/** 记录标签名称  */
@property (nonatomic, readonly) NSArray *titles;

/** 修改头部间距, 默认0 */
@property (nonatomic, assign) CGFloat headSpace;
/** 修改尾部间距, 默认0 */
@property (nonatomic, assign) CGFloat trailSpace;
/** 修改标题标签的大小, 默认(80,35) */
@property (nonatomic, assign) CGSize itemSize;
/** 修改标签间距, 默认0 */
@property (nonatomic, assign) CGFloat space;

/** 修改normal状态的字体，默认大小为系统样式15号 */
@property (nonatomic, strong) UIFont *normalFont;
/** 修改selected状态的字体，默认大小为系统样式15号 */
@property (nonatomic, strong) UIFont *selectedFont;
/** 修改normal状态的字体颜色，默认为黑色 */
@property (nonatomic, strong) UIColor *normalColor;
/** 修改selected状态的字体颜色，默认为红色 */
@property (nonatomic, strong) UIColor *selectedColor;

/** 通过修改索引值来修改选中的标签(索引值从0开始递增) */
@property (nonatomic, assign) NSInteger selectedIndex;
/** 设置标签自动滑动，默认为不自动滑动(NO) */
@property (nonatomic, assign, getter=isAutoScroll) BOOL autoScroll;
/** 设置标签缩放动画, 默认不开启缩放动画(NO) */
@property (nonatomic, assign, getter=isScale) BOOL scale;
/** 设置边缘弹性效果,默认(NO) */
@property (nonatomic, assign, getter=isBounces) BOOL bounces;
/** 修改线条显示状态，默认不显示(NO) */
@property (nonatomic, assign, getter=isShowLine) BOOL showLine;
/** 修改线条颜色，默认蓝色 */
@property (nonatomic, strong) UIColor *lineColor;

@end

/** 标签点击的回调事件代码块 */
typedef void(^ClickHandler)(NSInteger tag);
@interface XYSTitleBar()
@property (nonatomic, copy) ClickHandler clickHandler;
/** 用户通过调用此函数获取标签点击时回传的tag值 */
- (void)clickHandler:(ClickHandler)clickHandler;
@end
