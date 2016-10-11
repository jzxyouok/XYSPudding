#import "XYSNavigationController.h"

@implementation XYSNavigationController

/** 默认参数配置 */
+ (void)initialize
{
    if (self == [XYSNavigationController class]) //防止父类中的参数影响
    {
        UINavigationBar *barAppearance = [UINavigationBar appearance]; //设置导航栏外观
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary]; //设置导航栏标签字体属性
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:20];
        attributes[NSForegroundColorAttributeName] = [UIColor blackColor];
        barAppearance.titleTextAttributes = attributes;
    }
}

/** 工厂模式创建对象 */
+ (instancetype)navigationWithRootViewController:(UIViewController *)rootViewController;
{
    return [[self alloc] initWithRootViewController:rootViewController];
}

/** 加载视图配置 */
- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
