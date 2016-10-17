#import "XYSTitleBar.h"
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
/** 默认底线颜色 */
#define kLineColor [UIColor blueColor]

/** 默认头部间距 */
#define kHeadSpace 0
/** 默认尾部间距 */
#define kTrailSpace 0
/** 默认标签间距 */
#define kSpace 0
/** 默认标签大小 */
#define kItemSize CGSizeMake(80, 35)

/** tag相加的常数 */
#define kTagConstant 3209
/** 线条移动的动画时长 */
#define kLineAnimationDuration 0.5

@interface XYSTitleBar ()<UIScrollViewDelegate>
{
    /** 记录特殊处理的间距 */
    NSNumber *_specialSpace;
    /** 记录当前选中的标签 */
    XYSTitleItem *_selectedItem;
}
/** 展示标签的滑动展示视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 底线 */
@property (nonatomic, strong) UIView *lineView;

@end

@implementation XYSTitleBar

#pragma mark - init

/** 唯一的工厂方法实例化对象 */
+ (id)barWithTitles:(NSArray *)titles
{
    return [[self alloc] initWithTitles:titles];
}
- (instancetype)initWithTitles:(NSArray *)titles
{
    if (self = [super init])
    {
        _titles = [titles copy];
        _space = kSpace;
        _headSpace = kHeadSpace;
        _trailSpace = kTrailSpace;
        _itemSize = kItemSize;
        
        _normalColor = kNormalColor;
        _selectedColor = kSelectedColor;
        _normalFont = kNormalFont;
        _selectedFont = kSelectedFont;
        
        _lineColor = kLineColor;
    }
    return self;
}

#pragma mark - 间距特殊处理

/** 所有标签展示总宽度小于展示视图的宽度(自动增加间距) */
- (CGFloat)space
{
    if (!_specialSpace)
    {
        /** 计算总宽度 */
        CGFloat allWith = _headSpace + _itemSize.width*_titles.count + _trailSpace + _space*(_titles.count-1);
        /**宽度差 */
        CGFloat distance = self.bounds.size.width - allWith;
        if (distance > 0)
        {
            /** 调整间距 */
            _space += distance/_titles.count;
        }
        
        _specialSpace = @(_space);
    }
    
    return (CGFloat)_specialSpace.doubleValue;
}

/** 通过修改索引值来修改选中的标签 */
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    /** 规避重复设置 */
    if (_selectedIndex == selectedIndex){return;}
    
    /** 取消上个标签的状态 */
    [_selectedItem setDisabled:NO];
    [_selectedItem setSelected:NO];
    
    _selectedIndex = selectedIndex;
    /** 配置选中的标签参数 */
    [self didConfigSelectItem];
}

#pragma mark - 视图

/** 创建展示标签的滑动视图*/
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [UIScrollView new];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setDelegate:self];
        [_scrollView setBounces:_bounces];
        [_scrollView setBackgroundColor:self.backgroundColor];
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.edges.mas_equalTo(0);
        }];
        
        /** 在滑动展示视图上添加标签视图和线条 */
        [self addItems];
        
        if (_showLine)
        {
            [self addLineView];
        }
    }
    return _scrollView;
}

/** 添加标签视图 */
- (void)addItems
{
    NSInteger count = _titles.count;
    for (NSInteger i = 0; i < count; i++)
    {
        XYSTitleItem *item = [XYSTitleItem new];
        [item setNormalColor:_normalColor];
        [item setSelectedColor:_selectedColor];
        [item setNormalFont:_normalFont];
        [item setSelectedFont:_selectedFont];
        [item setCanScale:_scale];
        [item setTag:i+kTagConstant];
        [item setText:_titles[i]];
        [item clickHandler:^(NSInteger index)
         {
             if (_clickHandler)
             {
                 _clickHandler(index-kTagConstant);
             }
             [self setSelectedIndex:index-kTagConstant];
         }];
        [_scrollView addSubview:item];
        
        /** 将第一个标签设置为默认选中的标签, 记录选中的标签索引值 */
        if (i == 0)
        {
            [item setSelected:YES];
            [item setDisabled:YES];
            _selectedIndex = i;
            _selectedItem = item;
        }
    }
}
/** 添加底线视图 */
- (void)addLineView
{
    _lineView = [UIView new];
    [_lineView setBackgroundColor:_lineColor];
    [_lineView setHidden:!_showLine];
    [_scrollView addSubview:_lineView];
}

#pragma mark - 参数配置

/** 将用户设置好的数据来配置视图 */
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    /** 规避非法创建对象的事件 */
    NSAssert(_titles, @"%s titles不能为空，请使用XYSTitleBar类提供的工厂方法barWithTitles创建对象", __func__);
    /** 显示滑动展示视图 */
    [self.scrollView setHidden:NO];
}

/** 设置选中的标签 */
- (void)didConfigSelectItem
{
    /** 设置新选中的标签的状态 */
    _selectedItem = (XYSTitleItem *)[_scrollView viewWithTag:_selectedIndex + kTagConstant];
    [_selectedItem setSelected:YES];
    [_selectedItem setDisabled:YES];

    /** 开启滑动动画 */
    [self startScrollAnimation];
}

/** 自动滑动动画 */
- (void)startScrollAnimation
{
    if (!_autoScroll)
    {
        [self startLineMoveAnimation];
        return;
    }
    if (_selectedItem.center.x > _scrollView.center.x &&
        _selectedItem.center.x < _scrollView.contentSize.width - _scrollView.center.x)
    {
        CGFloat offsetX = _selectedItem.center.x - _scrollView.center.x;
        
        if (offsetX + _scrollView.bounds.size.width > _scrollView.contentSize.width)
        {
            offsetX = _scrollView.contentSize.width - _scrollView.bounds.size.width;
            [self startLineMoveAnimation];
        }
        [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        return;
    }
    if (_selectedItem.center.x > _scrollView.center.x &&
        _scrollView.contentOffset.x != _scrollView.contentSize.width - _scrollView.bounds.size.width)
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width - _scrollView.bounds.size.width, 0) animated:YES];
        return;
    }
    if (_selectedItem.center.x < _scrollView.center.x &&
        _scrollView.contentOffset.x !=0)
    {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return;
    }
    [self startLineMoveAnimation];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    /** 开启线条移动动画 */
    [self startLineMoveAnimation];
}

/** 线条移动动画 */
- (void)startLineMoveAnimation
{
    if (!_showLine)
    {
        return;
    }
    [UIView animateWithDuration:kLineAnimationDuration
                     animations:^
     {
         CGFloat distance = _selectedItem.frame.origin.x - _lineView.frame.origin.x;
         [_lineView setTransform:CGAffineTransformTranslate(_lineView.transform, distance, 0)];
     }];
}

#pragma 布局

/** 布局标签视图 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_scrollView && _scrollView.bounds.size.width>0)
    {
        /** 设置展示视图容器大小 */
        CGFloat contentWith = _headSpace + _itemSize.width*_titles.count + _trailSpace + self.space*(_titles.count-1);
        [_scrollView setContentSize:CGSizeMake(contentWith, 0)];

        /** 布局标签 */
        NSInteger count = _titles.count;
        for (NSInteger i = 0; i < count; i++)
        {
            XYSTitleItem *item = [_scrollView viewWithTag:i+kTagConstant];
            [item mas_remakeConstraints:^(MASConstraintMaker *make) //布局按钮
             {
                 make.size.mas_equalTo(_itemSize);
                 make.centerY.mas_equalTo(_scrollView);
                 make.left.mas_equalTo(_headSpace+(_itemSize.width + _space)*i);
             }];
        }
        
        /** 布局线条 */
        if (_showLine)
        {
            [_lineView mas_remakeConstraints:^(MASConstraintMaker *make)
             {
                 make.left.mas_equalTo(0-_headSpace);
                 make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(0);
                 make.height.mas_equalTo(2);
                 make.width.mas_equalTo(_itemSize.width);
             }];
        }
    }
}

#pragma mark - 回调

/** 用户通过调用此函数获取标签点击时回传的tag值 */
- (void)clickHandler:(ClickHandler)handler
{
    _clickHandler = handler;
}

@end
