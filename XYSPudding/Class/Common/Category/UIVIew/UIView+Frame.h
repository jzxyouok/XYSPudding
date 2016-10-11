/*
    名称： UIView的分类（frame）
 
    作用：直接定义与视图的frame相关的参数，宽高、坐标、位置、大小、原点；

    目的：快速使用，避免冗长的代码。
*/

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic) CGFloat width; //窗口宽
@property (nonatomic) CGFloat height; //窗口高

@property (nonatomic) CGFloat x; //窗口x坐标
@property (nonatomic) CGFloat y; //窗口y坐标

@property (nonatomic) CGSize size; //窗口大小
@property (nonatomic) CGPoint origin; //窗口原点

@property (nonatomic, assign) CGPoint position; //窗口在父视图中的位置

@property (nonatomic) CGFloat positionX; //窗口位置x坐标
@property (nonatomic) CGFloat positionY; //窗口位置点y坐标

@property (nonatomic, assign, readonly) CGPoint selfCenter; //窗口本身的中心位置

@property (nonatomic) CGFloat selfCenterX; //窗口中心点x坐标
@property (nonatomic) CGFloat selfCenterY; //窗口中心点y坐标


/*!
 *  工厂模式快速创建带frame的视图对象
 */
+ (id)viewWithFrame:(CGRect)frame;

@end
