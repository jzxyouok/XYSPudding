#import "XYSTitleItem.h"

/** 定义快速设置RGB颜色的宏定义 */
#define kRGBColor(R,G,B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0]

/** 默认normal颜色 */
#define kNormalColor kRGBColor(80, 80, 80)
/** 默认selected颜色 */
#define kSelectedColor kRGBColor(168, 20, 4)
/** 默认normal字体 */
#define kNormalFont [UIFont systemFontOfSize:15]
/** 默认selected字体 */
#define kSelectedFont [UIFont systemFontOfSize:15]

/** 默认缩放比 */
#define kScaling 1.1
/** 默认动画时长 */
#define kAnimationDuration 0.3

@implementation XYSTitleItem

#pragma mark - 创建对象

/** 初始化参数 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _selectedColor = kSelectedColor;
        _selectedFont  = kSelectedFont;
        _canScale = YES;
        _scale = kScaling;

        [self setNormalColor:kNormalColor];
        [self setNormalFont:kNormalFont];
        [self setUserInteractionEnabled:YES]; //开启交互功能
        [self setTextAlignment:NSTextAlignmentCenter]; //文字居中
        [self setScaleStyle:XYSScaleStyleCenter]; //缩放动画样式
    }
    return self;
}

#pragma mark - 参数配置

/** 未选中标签时的字体 */
- (void)setNormalFont:(UIFont *)normalFont
{
    _normalFont = normalFont;
    if (!_selected)
    {
        [self setFont:_normalFont];
    }
}
/** 选中标签时的字体 */
- (void)setSelectedFont:(UIFont *)selectedFont
{
    _selectedFont = selectedFont;
    if (_selected && !_disabled)
    {
        [self setFont:_selectedFont];
    }
}
/** 未选中标签时的字体颜色 */
- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    if (!_selected)
    {
        [self setTextColor:_normalColor];
    }
}
/** 选中标签时的字体颜色 */
- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    if (_selected && !_disabled)
    {
        [self setTextColor:_selectedColor];
    }
}
/** 缩放动画的样式 */
- (void)setScaleStyle:(XYSScaleStyle)scaleStyle
{
    _scaleStyle = scaleStyle;
    
    switch (_scaleStyle)
    {
        case XYSScaleStyleCenter:
        {
            self.layer.anchorPoint = CGPointMake(0.5, 0.5);
            break;
        }
        case XYSScaleStyleLeftTop:
        {
            self.layer.anchorPoint = CGPointMake(0, 0);
            break;
        }
        case XYSScaleStyleLeftBottom:
        {
            self.layer.anchorPoint = CGPointMake(0, 1.0);
            break;
        }
        case XYSScaleStyleRightTop:
        {
            self.layer.anchorPoint = CGPointMake(1.0, 0);
            break;
        }
        case XYSScaleStyleRightBottom:
        {
            self.layer.anchorPoint = CGPointMake(1.0, 1.0);
            break;
        }
    }
}
/** 选中状态设置 */
- (void)setSelected:(BOOL)selected
{
    /** 规避重复操作,无用操作 */
    if (_disabled || _selected == selected){return;}
    
    /** 配置标签参数 */
    _selected = selected;
    [self configItem];
}

#pragma mark - 点击事件

/** 响应点击事件 */
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    /** 当前状态不可点击 */
    if (_disabled) {return;}
    
    /** 当前状态可以点击, 设置选中状态, 回传点击事件 */
    [self setSelected:!_selected];
    if (_clickHandler){_clickHandler(self.tag);}
}

/** 标签字体的缩放与还原动画 （scale：缩放比）*/
- (void)startScaleAnimation
{
    [UIView animateWithDuration:kAnimationDuration animations:^
     {
        self.textColor = _selected ? _selectedColor : _normalColor;
        self.font = _selected ? _selectedFont : _normalFont;
        self.transform = _selected ? CGAffineTransformMake(_scale, 0, 0, _scale, 0, 0) : CGAffineTransformIdentity;
     }];
}

/** 配置标签参数 */
- (void)configItem
{
    if (!_canScale)
    {
        /** 无缩放动画 */
        self.textColor = _selected ? _selectedColor : _normalColor;
        self.font = _selected ? _selectedFont : _normalFont;
    }
    else
    {
        /** 开始缩放动画 */
        [self startScaleAnimation];
    }
}

#pragma mark - 点击回调

/** 用户通过调用此函数获取标签点击时回传的tag值 */
- (void)clickHandler:(ClickHandler)clickHandler
{
    _clickHandler = clickHandler;
}

@end
