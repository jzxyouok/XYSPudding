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
        XYSNavigationController *nav = [XYSNavigationController navigationWithRootViewController:vc];
        
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
