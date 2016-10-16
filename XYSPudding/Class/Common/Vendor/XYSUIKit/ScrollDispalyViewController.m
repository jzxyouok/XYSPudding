#import "ScrollDispalyViewController.h"
#import "BlocksKit+UIKit.h"

@interface ScrollDispalyViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@end

@implementation ScrollDispalyViewController


/*!
 *  路径的种类:NSURL、http://、https://、file://
 *
 *
 */

- (BOOL)isURL:(id)path
{
    return [path isKindOfClass:[NSURL class]];
}

- (BOOL)isNetPath:(id)path
{
    return [path isKindOfClass:[NSString class]] &&
           [path rangeOfString:@"http"].length != NSNotFound &&
           [path rangeOfString:@"://"].length != NSNotFound;
}


//传入图片地址数据
- (instancetype)initWithImgPaths:(NSArray *)paths
{
    NSMutableArray *tempM = [NSMutableArray array];
    
    [paths enumerateObjectsUsingBlock:^(id _Nonnull obj,
                                        NSUInteger idx,
                                        BOOL * _Nonnull stop)
     {
//         UIImageView *imageView = [UIImageView new];
    
         UIButton *button = [UIButton new];
         button.tag = 1000 + idx;
         if ([self isURL:obj])
         {
             [button sd_setBackgroundImageWithURL:obj forState:0];
//             [imageView sd_setImageWithURL:obj]; //url图片
         }
         else if ([self isNetPath:obj])
         {
             [button sd_setBackgroundImageWithURL:[NSURL URLWithString:obj] forState:0];

//             [imageView sd_setImageWithURL:[NSURL URLWithString:obj]]; //网络地址图片
         }
         else if ([obj isKindOfClass:[NSString class]])
         {
             [button sd_setBackgroundImageWithURL:[NSURL fileURLWithPath:obj] forState:0];

//             [imageView sd_setImageWithURL:[NSURL fileURLWithPath:obj]]; //本地图片
         }
         else
         {
             [button setBackgroundImage:[UIImage imageNamed:@"error@3x"] forState:0];
//             imageView.image = [UIImage imageNamed:@"error@3x"]; //加载图片出错
         }

         UIViewController *vc = [UIViewController new];
//         vc.view = imageView;
         vc.view = button;
         
         
         [button bk_addEventHandler:^(id sender)
         {
             if ([_delegate respondsToSelector:@selector(scrollDispalyViewController:didSelectedWithIndex:)])
             {
                 [self.delegate scrollDispalyViewController:self didSelectedWithIndex:(button.tag-1000)];
             }
         } forControlEvents:UIControlEventTouchUpInside];
         [button setAdjustsImageWhenHighlighted:NO]; //取消点击高亮效果
         
         [tempM addObject:vc];
     }];
    
    if (self = [self initWithControllers:tempM]){}
    
    return self;
}

//传入图片数组
- (instancetype)initWithImgNames:(NSArray *)names
{
    
    NSMutableArray *tempM = [NSMutableArray array];
    
    [names enumerateObjectsUsingBlock:^(NSString * _Nonnull obj,
                                        NSUInteger idx,
                                        BOOL * _Nonnull stop)
     {
         UIImage *image = [UIImage imageNamed:obj];
//         UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
         UIButton *button = [UIButton new];
         button.tag = 100 + idx;
         [button setBackgroundImage:image forState:0];
         UIViewController *vc = [UIViewController new];
//         vc.view = imageView;
           vc.view = button;
         [button bk_addEventHandler:^(id sender)
          {
              if ([_delegate respondsToSelector:@selector(scrollDispalyViewController:didSelectedWithIndex:)])
              {
                  [self.delegate scrollDispalyViewController:self didSelectedWithIndex:(button.tag-100)];
              }
              
          } forControlEvents:UIControlEventTouchUpInside];
         [button setAdjustsImageWhenHighlighted:NO]; //取消点击高亮效果

         
         [tempM addObject:vc];
     }];

    if (self = [self initWithControllers:tempM]){}
    
    return self;
}

//传入视图控制器
- (instancetype)initWithControllers:(NSArray *)controllers
{
    if (self = [super init])
    {
        _controllers = [controllers copy];
        
        _canCycle = YES;
        _autoScroll = YES;
        _showPageControl = YES;
        _duration = 3.0;
        _pageControlOffsetY = 0;
    }
    
    return self;
}

- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    
    [_timer invalidate];
    if (!_autoScroll)
    {
        return;
    }
    
    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:_duration
                                                  block:^(NSTimer *timer)
    {
        UIViewController *vc = _pageVC.viewControllers.firstObject;
        NSInteger index = [_controllers indexOfObject:vc];
        
        UIViewController *nextVC = nil;
        if (index >= _controllers.count-1) //越界处理
        {
            if (!_canCycle)
            {
                return;
            }
            nextVC = [_controllers firstObject];
        }
        else
        {
            nextVC = _controllers[index+1];
        }
        
        __block ScrollDispalyViewController *vc1= self;
        [_pageVC setViewControllers:@[nextVC] direction:0 animated:YES completion:^(BOOL finished)
         {
             if (finished)
             {
                 [vc1 congfigPageControl];
             }
        }];

    } repeats:YES];
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    _pageController.hidden = !_pageController.hidden;
}

- (void)setDuration:(NSTimeInterval)duration
{
    _duration = duration;
    self.autoScroll = _autoScroll;
}

- (void)setPageControlOffsetY:(CGFloat)pageControlOffsetY
{
    _pageControlOffsetY = pageControlOffsetY;
    
    [_pageController mas_updateConstraints:^(MASConstraintMaker *make)
    {
        make.bottom.mas_equalTo(_pageControlOffsetY);
    }];
}


- (void)setCurrentPage:(NSInteger)currentPage
{
    
    NSInteger direction = 0;
    if (_currentPage == currentPage)
    {
        return;
    }
    
    else if (_currentPage > currentPage)
    {
        direction = 1;
    }
    else
    {
        direction = 0;
    }
    
    _currentPage = currentPage;
    UIViewController *vc = _controllers[currentPage];
    [_pageVC setViewControllers:@[vc]
                      direction:direction
                       animated:YES
                     completion:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_controllers || _controllers.count <= 0)
    {
        return;
    }
    
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:1
                                              navigationOrientation:0
                                                            options:nil];
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    
    //需要Masonary类库支持
    [_pageVC.view mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.mas_equalTo(self.view);
    }];
    [_pageVC setViewControllers:@[_controllers.firstObject]
                      direction:0
                       animated:NO
                     completion:nil];
    
    _pageController = [UIPageControl new];
    _pageController.numberOfPages = _controllers.count;
    _pageController.userInteractionEnabled = NO;
    [self.view addSubview:_pageController];
    [_pageController mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(0);
    }];
    
    self.autoScroll = _autoScroll;
    //self.showPageControl = _showPageControl;
    self.pageControlOffsetY = _pageControlOffsetY;
}

- (void)congfigPageControl
{
    NSInteger index = [_controllers indexOfObject:_pageVC.viewControllers.firstObject];
    _pageController.currentPage = index;
}

#pragma mark - UIPageViewControllerDataSource

/*!
 *  向右滑动
 */
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [_controllers indexOfObject:viewController];
    
    if (index <= 0) //越界处理
    {
        if (!_canCycle)
        {
            return nil;
        }
        
        return [_controllers lastObject];
    }
    
    return _controllers[index-1];
}

/*!
 *  向左滑动
 */
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [_controllers indexOfObject:viewController];
    
    if (index >= _controllers.count-1) //越界处理
    {
        if (!_canCycle)
        {
            return nil;
        }
        return [_controllers firstObject];
    }
    
    return _controllers[index+1];
}

/*!
 *  改变小圆点位置
 *
 */
- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed && finished)
    {
        [self congfigPageControl];
        
        if ([self.delegate respondsToSelector:@selector(scrollDispalyViewController:currentIndex:)])
        {
            [self.delegate scrollDispalyViewController:self currentIndex: _pageController.currentPage];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
