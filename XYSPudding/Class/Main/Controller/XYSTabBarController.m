#import "XYSTabBarController.h"
#import "XYSNavigationController.h"
#import "XYSTabBarModel.h"

@interface XYSTabBarController ()

/** 记录选择栏视图模型对象 */
@property (nonatomic, strong) NSArray *models;

@end

@implementation XYSTabBarController

/** 视图加载配置 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self didLoadChildrenViewControllers]; //载入子控制器
}

/** 配置子控制器 */
- (void)didLoadChildrenViewControllers
{
    _models = [XYSTabBarModel getModels]; //创建选择栏视图模型
    
    for (XYSTabBarModel *model in _models)
    {
        UIViewController *vc = [NSClassFromString(model.viewController) new];
        /** 自定义导航栏标题 */
        UILabel *titleLabel = [UILabel viewWithFrame:CGRectMake(0, 0, 100, 30)];
        [titleLabel setText:model.title];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        [titleLabel setTextColor:[UIColor orangeColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [vc.navigationItem setTitleView:titleLabel];
        
        XYSNavigationController *nav = [XYSNavigationController navigationWithRootViewController:vc];
        /** 配置选择栏标签 */
        UITabBarItem *tabBarItem = [UITabBarItem new];
        [tabBarItem setImage:[UIImage imageNamed:model.normalImage]];
        UIImage *originalImage = [[UIImage imageNamed:model.selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; //图片渲染，使用原始图片
        [tabBarItem setSelectedImage:originalImage];
        [tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
        [nav setTabBarItem:tabBarItem];

        [self addChildViewController:nav];
    }
}

@end
