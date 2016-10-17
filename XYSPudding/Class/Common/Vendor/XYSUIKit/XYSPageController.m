#import "XYSPageController.h"

@interface XYSPageController ()<UIScrollViewDelegate>
{
    /** 记录分页视图宽度 */
    CGFloat _kWidth;
    /** 记录分页视图宽度 */
    CGFloat _kHeight;
    /** 记录是否滑动过半 */
    BOOL _scrollHalf;
    /** 记录手动设置的控制器视图 */
    UIViewController *_setViewConttoller;
}
@end

@implementation XYSPageController

#pragma mark - init
+ (instancetype)pageWithCurrentViewController:(UIViewController *)viewController
                              scrollStyle:(XYSPageControllerScrollStyle)style
{
    return [[self alloc] initWithCurrentViewController:viewController scrollStyle:style];
}
- (instancetype)initWithCurrentViewController:(UIViewController *)viewController
                              scrollStyle:(XYSPageControllerScrollStyle)style
{
    if (self = [super init])
    {
        _currentViewController = viewController; //记录当前页面控制器
        _scrollStyle = style;
    }
    return self;
}

#pragma mark - 视图配置

/** 视图加载配置 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_currentViewController) //避免非法创建对象，使当前页面的视图为空
    {
        NSAssert(0, @"%s: currentViewController不能为空, 请使用本类提供的工厂方法(pageWithCurrentViewController:)实例化本类对象", __func__);
    }
    
    [self addScrollView];
}
/** 内存警告处理 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
/** 添加滑动视图 */
- (void)addScrollView
{
    _scrollView = [UIScrollView new];
    [_scrollView setDelegate:self];
    [_scrollView setBackgroundColor:self.view.backgroundColor];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setBounces:_bounces];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make)
    {
         make.edges.mas_equalTo(0);
     }];
    /** 添加当前页面显示的视图控制器 */
    [self addChildViewController:_currentViewController];
    [_scrollView addSubview:_currentViewController.view];
}

/** 手动设置当前页面显示的控制器视图 */
- (void)setCurrentViewController:(UIViewController *)viewController
                       direction:(XYSPageControllerScrollDirection)direction
                        animated:(BOOL)animated
{
    if (!viewController ||
        (_scrollStyle == XYSPageControllerScrollStyleHorizontal && _scrollView.contentOffset.x != _kWidth) ||
        (_scrollStyle == XYSPageControllerScrollStyleVertical && _scrollView.contentOffset.y != _kHeight))
    {
        return;
    }
    
    _setViewConttoller = viewController;
    [self dismissRedundantViewControllers];
    NSInteger index = 0;
    if (direction == XYSPageControllerScrollDirectionLeft) //滑动方向是左边(上边), 显示右侧(下侧)控制器视图
    {
        index = 2;
        _rightViewController = viewController;
    }
    else //滑动方向是右边(下边), 显示左侧(上侧)控制器视图
    {
        index = 0;
        _leftViewController = viewController;
    }
    [self addViewController:viewController index:index];
    [_scrollView setContentOffset:CGPointMake(_kWidth*index, _kHeight*index) animated:animated];
}

#pragma mark - <UIScrollViewDelegate>

/** 滑动视图开始滑动时调用 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > _kWidth || //向左滑动，显示右侧
        scrollView.contentOffset.y > _kHeight)  //向上滑动，显示上侧
    {
        if (_leftScrollHandler && !_rightViewController)
        {
            _leftScrollHandler(_currentViewController);
        }
    }
    else if (scrollView.contentOffset.x < _kWidth || //向右滑动,显示左侧
             scrollView.contentOffset.y < _kHeight) //向下滑动,显示下侧
    {
        if (_rightScrollHandler && !_leftViewController)
        {
            _rightScrollHandler(_currentViewController);
        }
    }
    [self displaySideViewController]; //显示侧边视图
}
/** 滑动视图结束加速时调用（分页滑动的前提保证）*/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /** 当前可见页面是否在侧边（在，替换视图） */
    if (_leftViewController && ((_scrollView.contentOffset.x == 0 && _kWidth !=0) ||
                                (_scrollView.contentOffset.y == 0 && _kHeight !=0)))
    {
        [self replaceCurrentViewControllerWithViewController:_leftViewController];
    }
    else if (_rightViewController && (( _scrollView.contentOffset.x == _kWidth*2 && _kWidth !=0) ||
                                      ( _scrollView.contentOffset.y == _kHeight*2 && _kHeight !=0)))
    {
        [self replaceCurrentViewControllerWithViewController:_rightViewController];
    }
    [self dismissRedundantViewControllers];
    [self layoutCurrentViewControllerWithIndex:1];
    
    if (_didCompleteScroll)
    {
        _didCompleteScroll(_currentViewController);
    }
}
/** 结束滑动动画 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_setViewConttoller) //是否通过set设置控制器视图
    {
        [self replaceCurrentViewControllerWithViewController:_setViewConttoller];
        [self layoutCurrentViewControllerWithIndex:1];
        _setViewConttoller = nil;
    }
    
    [self scrollViewDidEndDecelerating:scrollView];
}
/** 用户开始Drag */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_willDrag)
    {
        _willDrag(_currentViewController);
    }
}
/** 用户结束drag动作 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (_didEndDrag)
    {
        _didEndDrag(_currentViewController);
    }
}

#pragma mark - 代码整理

/** 显示侧边的视图控制器 */
- (void)displaySideViewController
{
    if (_leftViewController && (_scrollView.contentOffset.x < _kWidth || //显示左侧视图
                                _scrollView.contentOffset.y < _kHeight )) //显示上侧视图
    {
        if (_rightViewController) //移除右侧视图
        {
            [self dismissViewController:_rightViewController];
        }
        if ([self existViewController:_leftViewController]) //规避重复添加
        {
            if (_scrollView.contentOffset.x < 0 ||
                _scrollView.contentOffset.y < 0) // 越界，更新currentViewController视图
            {
                [self replaceCurrentViewControllerWithViewController:_leftViewController];
                [self layoutCurrentViewControllerWithIndex:1];
            }
            return;
        }
        [self addViewController:_leftViewController index:0];
    }
    else if (_rightViewController  && ( _scrollView.contentOffset.x > _kWidth || //显示右侧视图
                                       _scrollView.contentOffset.y > _kHeight )) //显示下侧视图
    {
        if (_leftViewController) //移除左侧视图
        {
            [self dismissViewController:_leftViewController];
        }
        if ([self existViewController:_rightViewController]) //规避重复添加
        {
            if (_scrollView.contentOffset.x > _kWidth*2 ||
                _scrollView.contentOffset.y > _kHeight*2) //越界，更新currentViewController视图
            {
                [self replaceCurrentViewControllerWithViewController:_rightViewController];
                [self layoutCurrentViewControllerWithIndex:1];
            }
            return;
        }
        [self addViewController:_rightViewController index:2];
    }
    else if (!_rightViewController || !_leftViewController) //侧边无视图（显示边界的弹性效果，如果可用)
    {
        [self dismissRedundantViewControllers];
        
        if ((_currentViewController.view.frame.origin.x == _kWidth && _scrollView.contentOffset.x != _kWidth) ||
            (_currentViewController.view.frame.origin.y == _kHeight && _scrollView.contentOffset.y != _kHeight))
        {
            if (_scrollView.contentOffset.x > _kWidth ||
                _scrollView.contentOffset.y > _kHeight)
            {
                [self layoutCurrentViewControllerWithIndex:2];
            }
            else if (_scrollView.contentOffset.x < _kWidth ||
                     _scrollView.contentOffset.y < _kHeight)
            {
                [self layoutCurrentViewControllerWithIndex:0];
            }
        }
        else if (((_scrollView.contentOffset.x >= 0 && _scrollView.contentOffset.x < _kWidth*0.5) ||    //复原
                  (_scrollView.contentOffset.x <= _kWidth*2 && _scrollView.contentOffset.x > _kWidth*1.5)) ||
                 ((_scrollView.contentOffset.y >= 0 && _scrollView.contentOffset.y < _kHeight*0.5) ||
                  (_scrollView.contentOffset.y <= _kHeight*2 && _scrollView.contentOffset.y > _kHeight*1.5)))
        {
            [self layoutCurrentViewControllerWithIndex:1];
        }
    }
}

/** 更换当前页面的控制器视图（移除原先的控制器视图) */
- (void)replaceCurrentViewControllerWithViewController:(UIViewController *)viewController
{
    [_currentViewController removeFromParentViewController];
    [_currentViewController.view removeFromSuperview];
    _currentViewController = nil;
    _currentViewController = viewController;
    
    [self dismissRedundantViewControllers];
}
/** 添指定加视图控制器 */
- (void)addViewController:(UIViewController *)viewController
                       index:(NSInteger)index
{
    [self addChildViewController:viewController];
    [_scrollView addSubview:viewController.view];
    [viewController.view mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.size.mas_equalTo(_scrollView);
         make.left.mas_equalTo(_kWidth*index);
         make.top.mas_equalTo(_kHeight*index);
     }];
}
/** 释放指定的控制器视图 */
- (void)dismissViewController:(UIViewController *)viewController
{
    [viewController removeFromParentViewController];
    [viewController.view removeFromSuperview];
    (viewController == _leftViewController) ? (_leftViewController = nil) : (_rightViewController = nil);
}
/** 释放多余的控制器视图 */
- (void)dismissRedundantViewControllers
{
    _leftViewController = nil;
    _rightViewController = nil;
    for (UIViewController *vc in [self childViewControllers])
    {
        if ([vc isEqual:_currentViewController]) //保留当前页面显示的视图控制器
        {
            continue;
        }
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}
/** 判断目标视图控制器是否存在self对象中 */
- (BOOL)existViewController:(UIViewController *)viewController
{
    for (UIViewController *vc in [self childViewControllers])
    {
        if ([vc isEqual:viewController])
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 布局

/** 结束视图布局 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (_scrollStyle == XYSPageControllerScrollStyleHorizontal)
    {
        _kWidth = self.view.bounds.size.width; //记录分页视图宽度
        _kHeight = 0;
    }
    else
    {
        _kWidth = 0; //记录分页视图宽度
        _kHeight = self.view.bounds.size.height;
    }
    
    [_scrollView setContentSize:CGSizeMake(_kWidth*3, _kHeight*3)]; //设置滑动视图的内容大小
    [self layoutCurrentViewControllerWithIndex:1];
}
/** 布局当前页面的控制其视图 */
- (void)layoutCurrentViewControllerWithIndex:(NSInteger)index
{
    [_currentViewController.view mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_kHeight*index);
         make.left.mas_equalTo(_kWidth*index);
         make.size.mas_equalTo(_scrollView);
     }];
    [_scrollView setContentOffset:CGPointMake(_kWidth*index, _kHeight*index)]; //设置滑动视图的可见视图偏移坐标
}

#pragma mark - 委托用户操作的回调代码

/** 用户在该代码块中，设置左侧的控制器视图 */
- (void)didLoadLeftViewController:(RightScrollHandler)handler
{
    _rightScrollHandler = handler;
}
/** 用户在该代码块中，设置右侧的控制器视图 */
- (void)didLoadRightViewController:(LeftScrollHandler)handler
{
    _leftScrollHandler = handler;
}

/** 滑动完全结束的事件回调操作*/
- (void)handlerForDidCompleteScroll:(HandlerForDidCompleteScroll)handler
{
    _didCompleteScroll = handler;
}
/** 用户即将drag的事件回调操作 */
- (void)handlerForWillStartDrag:(HandlerForWillStartDrag)handler
{
    _willDrag = handler;
}
/** 用户结束drag的事件回调操作 */
- (void)handlerForDidEndDrag:(HandlerForDidEndDrag)handler
{
    _didEndDrag = handler;
}
@end
