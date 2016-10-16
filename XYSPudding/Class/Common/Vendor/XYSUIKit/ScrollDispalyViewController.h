#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h" //使用网络图片，需要SDWebImage支持https://github.com/rs/SDWebImage
#import "UIButton+WebCache.h"

@class ScrollDispalyViewController;

@protocol ScrollDispalyViewControllerDelegate <NSObject>


@optional

/*!
 *  当用户点击了某页，响应
 *  @param scrollDispalyViewController 点击的对象控制器视图
 *  @param index                       下标
 */
- (void)scrollDispalyViewController:(ScrollDispalyViewController *)scrollDispalyViewController
               didSelectedWithIndex:(NSInteger)index;

/*!
 *  实时传递当前的索引值
 *
 */
- (void)scrollDispalyViewController:(ScrollDispalyViewController *)scrollDispalyViewController
                       currentIndex:(NSInteger)index;

@end


@interface ScrollDispalyViewController : UIViewController

{
    NSTimer *_timer;
}
/*!
 *  记录传入的数据
 */
@property (nonatomic, strong, readonly) NSArray *controllers;
@property (nonatomic, strong, readonly) NSArray *names;
@property (nonatomic, strong, readonly) NSArray *paths;

//传入图片地址数据
- (instancetype)initWithImgPaths:(NSArray *)paths;

//传入图片数组
- (instancetype)initWithImgNames:(NSArray *)names;

//传入视图控制器
- (instancetype)initWithControllers:(NSArray *)controllers;

@property (nonatomic, strong, readonly) UIPageViewController *pageVC;
@property (nonatomic, strong, readonly) UIPageControl *pageController;

@property (nonatomic, weak) id<ScrollDispalyViewControllerDelegate> delegate;


@property (nonatomic, assign) BOOL canCycle; //循环滚动, 默认YES
@property (nonatomic, assign) BOOL autoScroll; //自动滚动, 默认YES
@property (nonatomic, assign) NSTimeInterval duration; //滚动时间，默认3s
@property (nonatomic, assign) BOOL showPageControl; //显示小圆点
@property (nonatomic, assign) NSInteger currentPage; //当前页

@property (nonatomic, assign) CGFloat pageControlOffsetY;



@end
