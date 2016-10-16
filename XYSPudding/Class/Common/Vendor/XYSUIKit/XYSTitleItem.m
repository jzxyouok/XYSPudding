#import "XYSTitleItem.h"

#define kSelectedColor [UIColor colorWithRed:168/255.0 green:20/255.0 blue:4/255.0 alpha:1] //默认selected颜色
#define kNormalColor [UIColor colorWithRed:0 green:0 blue:0 alpha:1] //默认normal颜色
#define kNormalFont [UIFont systemFontOfSize:15] //默认normal字体
#define kSelectedFont [UIFont systemFontOfSize:16] //默认selected字体

@implementation XYSTitleItem

#pragma mark - 创建对象

/** 初始化参数 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _normalColor   = kNormalColor;
        _selectedColor = kSelectedColor;
        self.normalFont = kNormalFont;
        _selectedFont  = kSelectedFont;
        _canScale = YES;
        _scaleStyle = XYSScaleStyleCenter;
        
        self.userInteractionEnabled = YES;
        self.textAlignment = NSTextAlignmentCenter; //文字居中
        self.scaleStyle = XYSScaleStyleCenter;

    }
    return self;
}

#pragma mark - 参数配置

- (void)setNormalFont:(UIFont *)normalFont
{
    _normalFont = normalFont;
    if (!_selected)
    {
        self.font = _normalFont;
    }
}

- (void)setSelectedFont:(UIFont *)selectedFont
{
    _selectedFont = selectedFont;
    if (_selected)
    {
        self.font = _selectedFont;
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

/** 动画缩放比 */
- (CGFloat)scale
{
    if (!_canScale)
    {
        return 1;
    }
    return _selectedFont.pointSize/_normalFont.pointSize;
}

- (void)setSelected:(BOOL)selected
{
    if (_selected == selected)
    {
        return;
    }
    _selected = selected;
    [self configItem];
}

/** 标签字体的缩放与还原动画 （scale：缩放比）*/
- (void)animationWithScale:(CGFloat)scale
{
    [UIView animateWithDuration:0.3 animations:^
     {
        self.textColor = _selected ? _selectedColor : _normalColor;
        self.font = _selected ? _selectedFont : _normalFont;
        self.transform = _selected ? CGAffineTransformMake(scale, 0, 0, scale, 0, 0) : CGAffineTransformIdentity;
     }];
}

/** 配置标签 */
- (void)configItem
{
     _selected && _clickHandler ?  _clickHandler(self.tag) : nil;
    if (!_canScale)
    {
        self.textColor = _selected ? _selectedColor : _normalColor;
        self.font = _selected ? _selectedFont : _normalFont;
    }
    else
    {
        [self animationWithScale:self.scale];
    }
}

/** 标签的点击响应事件 */
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    if (_disabled)
    {
        return;
    }
    
    _selected = !_selected;
    [self configItem];
}

#pragma mark - 点击回调

- (void)clickHandler:(ClickHandler_)clickHandler
{
    _clickHandler = clickHandler;
}

@end
