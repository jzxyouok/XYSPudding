/*!
 *  定义一些常用的宏函数、宏常量...
 */

#ifndef XYSMacro_h
#define XYSMacro_h
#endif /* XYSMacro_h */
/*!
 *  定义设备屏幕的相关属性宏
 */

#ifndef kScreenWidth
#define kScreenWidth [UIScreen mainScreen].bounds.size.width //设备屏幕宽度
#endif
#ifndef kScreenHeight
#define kScreenHeight [UIScreen mainScreen].bounds.size.height //设备屏幕高度
#endif
#ifndef kScreenBounds
#define kScreenBounds [UIScreen mainScreen].bounds //设备的自身的边框
#endif

/*!
 *  定义颜色相关宏
 */

#ifndef kRGBColor
#define kRGBColor(R,G,B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0] //快速设置RGB颜色
#endif
#ifndef kHexColor
#define kHexColor(hex) [UIColor colorWithHex:(hex)] //快速设置16进制颜色（需要UIColor+Hex_255类别支持）
#endif

/*!
 *  定义窗口相关宏
 */

#ifndef kKeyWindow
#define kKeyWindow [UIApplication sharedApplication].keyWindow //主窗口
#endif
#ifndef kRootController
#define kRootController [UIApplication sharedApplication].keyWindow.rootViewController //主窗口根视图控制器
#endif

/*!
 *  通过第id 获取故事板中的对象
 */

#ifndef kMainStoryBoardObj
#define kMainStoryBoardObj(identifier) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:(identifier)]
#endif
#ifndef kStoryBoardObj
#define kStoryBoardObj(name, identifier) [[UIStoryboard storyboardWithName:(name) bundle:nil] instantiateViewControllerWithIdentifier:(identifier)]
#endif

/*!
 *  移除iOS7之后，cell默认左侧的分割线边距
 */

#ifndef kRemoveCellSideSpace
#define kRemoveCellSideSpace \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath\
{\
    cell.separatorInset = UIEdgeInsetsZero;\
    cell.layoutMargins = UIEdgeInsetsZero; \
    cell.preservesSuperviewLayoutMargins = NO; \
}
#endif

/*!
 *  定义沙盒中的文件夹目录相关宏
 */

#ifndef kDocumentsPath
#define kDocumentsPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject //获取Document文件夹路径
#endif
#ifndef kCachePath
#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject //获取cache文件夹路径
#endif
#ifndef kLibaryPath
#define kLibaryPath NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject //获取Libary文件夹路径
#endif
#ifndef kTempPath
#define kTempPath NSTemporaryDirectory()
#endif

/*!
 *  Bundle相关的宏
 */

#ifndef kBundlePath
#define kBundlePath(name, extension)   [[NSBundle mainBundle] pathForResource:(name) ofType:(extension)] //获取bundle中的文件路径
#endif

#ifndef kPlistArrayInBundle
#define kPlistArrayInBundle(name)  [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"plist"]] //获取bundle中的plist
#endif
#ifndef kPlistDictionaryInBundle
#define kPlistDictionaryInBundle(name) [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"plist"]] //获取bundle中的plist
#endif



