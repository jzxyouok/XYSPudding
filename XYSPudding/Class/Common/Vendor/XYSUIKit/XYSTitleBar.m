#import "XYSTitleBar.h"
#import "XYSTitleItem.h"

#define kSelectedColor [UIColor colorWithRed:168/255.0 green:20/255.0 blue:4/255.0 alpha:1] //默认selected颜色
#define kNormalColor [UIColor colorWithRed:0 green:0 blue:0 alpha:1] //默认normal颜色
#define kNormalFont [UIFont systemFontOfSize:15] //默认normal字体
#define kSelectedFont [UIFont systemFontOfSize:16] //默认selected字体
#define kLineColor [UIColor blueColor] //底线默认颜色

@interface XYSTitleBar ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation XYSTitleBar

#pragma mark - init

+ (id)barWithTitles:(NSArray *)titles
{
    return [[self alloc] initWithTitles:titles];
}

- (instancetype)initWithTitles:(NSArray *)titles
{
    if (self = [super init])
    {
        _titles = [titles copy];
        _space = 0;
        _headSpace = 0;
        _trailSpace = 0;
        _size = CGSizeMake(80, 35);
        
        _normalColor = kNormalColor;
        _selectedColor = kSelectedColor;
        _normalFont = kNormalFont;
        _selectedFont = kSelectedFont;
        _autoScroll = NO;
        _showLine = YES;
        _lineColor = kLineColor;
    }
    
    return self;
}

/** 设置选中的标签 */
- (void)setSelectedItem:(NSInteger)selectedItem
{
    [self didConfigSelectedItemWithIndex:selectedItem+100];
}

/** 设置底线颜色 */
- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [_lineView setBackgroundColor:_lineColor];
}

- (void)setShowLine:(BOOL)showLine
{
    _showLine = showLine;
    
    _lineView.hidden = !_showLine;
}

#pragma mark - 参数配置

/** 所有标签展示总宽度小于父视图宽度(自动增加间距) */
- (void)specialConfigForItemsSpace
{
    CGFloat showItemsWidth = (_size.width + _space) * _titles.count + _headSpace+_trailSpace;
    CGFloat distance = _scrollView.bounds.size.width - showItemsWidth;
    if (distance > 0)
    {
        _space += distance/_titles.count;
    }
    _scrollView.contentSize = CGSizeMake((_size.width + _space)*_titles.count+_headSpace+_trailSpace,0);
}

/** 添加滑动视图（展示标签）*/
- (void)addScrollView
{
    _scrollView = [UIScrollView new];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = self.backgroundColor;
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.mas_equalTo(0);
     }];
}

/** 添加标签视图 */
- (void)addItems
{
    NSInteger count = _titles.count;
    for (NSInteger i = 0; i < count; i++)
    {
        XYSTitleItem *item = [XYSTitleItem new];
        item.normalColor = _normalColor;
        item.selectedColor = _selectedColor;
        item.normalFont = _normalFont;
        item.selectedFont = _selectedFont;
        item.tag = i+100;
        item.text = _titles[i];
        
        __block XYSTitleBar *blockSelf = self;
        [item clickHandler:^(NSInteger index)
        {
            [blockSelf didConfigSelectedItemWithIndex:index];
        }];
        [_scrollView addSubview:item];
        
        if (i == 0) //默认选中的标签
        {
            item.selected = YES;
            item.disabled = YES;
            _selectedItem = i;
        }
    }
}

/** 添加底线视图 */
- (void)addLineView
{
    UIView *lineView = [UIView new];
    _lineView = lineView;
    [lineView setBackgroundColor:_lineColor];
    [_scrollView addSubview:lineView];
}

/** 设置选中的标签 */
- (void)didConfigSelectedItemWithIndex:(NSInteger)index;
{
    if (_selectedItem != index-100)
    {
        _clickHandler ? _clickHandler(index-100) : 0;

        XYSTitleItem *lastSelectedItem = [_scrollView viewWithTag:_selectedItem+100];
        lastSelectedItem.disabled = NO;
        lastSelectedItem.selected = NO;
        
        _selectedItem = index - 100;
        XYSTitleItem *currentSelectedItem = [_scrollView viewWithTag:_selectedItem+100];
        currentSelectedItem.selected = YES;
        currentSelectedItem.disabled = YES;
        
        if (_autoScroll) //自动滑动处理
        {
            if (currentSelectedItem.center.x > _scrollView.center.x)
            {
                CGFloat offsetX = currentSelectedItem.center.x - _scrollView.center.x;
                
                if (_scrollView.contentSize.width-currentSelectedItem.center.x<_scrollView.center.x)
                {
                    offsetX = _scrollView.contentSize.width-_scrollView.bounds.size.width;
                }
                
                [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            }
            else if (currentSelectedItem.center.x > 0)
            {
                [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
        
        [self animationForLineView];
    }
}

/** 底线视图动画 */
- (void)animationForLineView
{
    XYSTitleItem *item = [_scrollView viewWithTag:_selectedItem+100];

    [UIView animateWithDuration:0.5
                     animations:^
     {
         CGPoint center =   _lineView.center;
         center.x = item.center.x;
         _lineView.center = center;
     }];
}

/** 添加子视图 */
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    NSAssert(_titles, @"%s titles不能为空，请使用XYSTitleBar类提供的工厂方法barWithTitles创建对象", __func__);
    
    [self addScrollView];
    [self addItems];
    [self addLineView];
}

#pragma 布局

/** 布局标签视图 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_scrollView && _scrollView.bounds.size.width>0)
    {
        [self specialConfigForItemsSpace];
        NSInteger count = _titles.count;
        for (NSInteger i = 0; i < count; i++)
        {
            XYSTitleItem *item = [_scrollView viewWithTag:i+100];
            [item mas_remakeConstraints:^(MASConstraintMaker *make) //布局按钮
             {
                 make.size.mas_equalTo(_size);
                 make.centerY.mas_equalTo(_scrollView);
                 make.left.mas_equalTo(_headSpace+(_space + _size.width)*i); //布局第一个按钮
             }];
        }
        
        [_lineView setFrame:CGRectMake(_headSpace+(_space + _size.width)*_selectedItem,
                                       _scrollView.bounds.size.height-2,
                                       _size.width,
                                       2)];
    }
}

#pragma mark - 回调传值

/*!
 *  用户获取传出的标签索引，设置相应处理事件
 *
 *  @param handler 回调代码
 */
- (void)clickHandler:(ClickHandler)handler //回调操作
{
    _clickHandler = handler;
}

@end
