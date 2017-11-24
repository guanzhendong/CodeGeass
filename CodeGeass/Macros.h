
#ifndef Macros_h
#define Macros_h





#pragma mark -
#pragma mark Empty object

static inline BOOL IsEmptyObject(id object) {
    return object == nil
        || [object isEqual:[NSNull null]]
        || ([object respondsToSelector:@selector(length)] && ([(NSData *)object length] == 0 || [(NSString *)object length] == 0))
        || ([object respondsToSelector:@selector(count)] && ([(NSArray *)object count] == 0 || [(NSDictionary *)object count] == 0));
}

static inline BOOL IsValidObject(id object) {
    return !IsEmptyObject(object);
}

static inline NSString *StringFromObject(id object) {
	if (object == nil || [object isEqual:[NSNull null]]) {
		return @"";
	} else if ([object isKindOfClass:[NSString class]]) {
		return object;
	} else if ([object respondsToSelector:@selector(stringValue)]){
		return [object stringValue];
	} else {
		return [object description];
	}
}



#pragma mark -
#pragma mark iOS Version

#define IOS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:[NSString stringWithFormat:@"%f",v] options:NSNumericSearch] != NSOrderedAscending)
#define IOS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IOS_8   IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(8)
#define IOS_9   IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(9)
#define IOS_10  IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(10)



#pragma mark -
#pragma mark UIColor

#define COLOR_HEXA(hexValue,a)         [UIColor colorWithRed:((hexValue & 0xFF0000) >> 16) / 255.0 \
                                                       green:((hexValue & 0xFF00) >> 8) / 255.0    \
                                                        blue:(hexValue & 0xFF) / 255.0             \
                                                       alpha:a]
#define COLOR_HEX(hexValue)            COLOR_HEXA(hexValue,1.0)
#define COLOR_RGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define COLOR_RGB(r,g,b)               COLOR_RGBA(r,g,b,1.0)



#pragma mark -
#pragma mark Frame Geometry

#define WIDTH(view) view.frame.size.width
#define HEIGHT(view) view.frame.size.height
#define X(view) view.frame.origin.x
#define Y(view) view.frame.origin.y
#define LEFT(view) view.frame.origin.x
#define TOP(view) view.frame.origin.y
#define BOTTOM(view) (view.frame.origin.y + view.frame.size.height) 
#define RIGHT(view) (view.frame.origin.x + view.frame.size.width) 



#pragma mark -
#pragma mark IndexPath

#define INDEX_PATH(a,b) [NSIndexPath indexPathWithIndexes:(NSUInteger[]){a,b} length:2]



#pragma mark -
#pragma mark weakSelf strongSelf

#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF __strong __typeof(weakSelf)strongSelf = weakSelf;



#pragma mark -
#pragma mark Device type. 
// Corresponds to "Targeted device family" in project settings
// Universal apps will return true for whichever device they're on. 
// iPhone apps will return true for iPhone even if run on iPad.

#define TARGETED_DEVICE_IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define TARGETED_DEVICE_IS_IPHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
#define TARGETED_DEVICE_IS_IPHONE_568 TARGETED_DEVICE_IS_IPHONE && ScreenHeight == 568



#pragma mark -
#pragma mark Transforms（角度转弧度）

#define DEGREES_TO_RADIANS(degrees) degrees * M_PI / 180



#pragma mark -
#pragma mark - 单例宏

#define SINGLETON_INTERFACE(className) + (instancetype)shared##className;

#define SINGLETON_IMPLEMENTATION(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        instance = [super allocWithZone:zone]; \
    }); \
    return instance; \
} \
 \
+ (instancetype)shared##className { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        instance = [[self alloc] init]; \
    }); \
    return instance; \
} \
 \
- (id)copyWithZone:(NSZone *)zone { \
    return instance; \
}



#pragma mark -
#pragma mark - 提示框（UIAlertController）

#define ZDALERT(TITLE, MESSAGE, BUTTONTITLE) \
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:TITLE message:MESSAGE preferredStyle:UIAlertControllerStyleAlert]; \
[alertController addAction:[UIAlertAction actionWithTitle:BUTTONTITLE style:UIAlertActionStyleDefault handler:nil]]; \
[self presentViewController:alertController animated:YES completion:nil];



#pragma mark -
#pragma mark - Size

/** 屏幕尺寸 */
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

/** 屏幕宽度 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

/** 屏幕高度 */
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/** 判断iPhoneX */
#define IS_iPhoneX (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812)

/** 状态栏高度 */
#define STATUS_BAR_HEIGHT (IS_iPhoneX ? 44 : 20)

/** 导航栏高度 */
#define NAVIGATION_BAR_HEIGHT 44

/** 状态栏＋导航栏 高度 */
#define STATUS_AND_NAVIGATION_HEIGHT (STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)

/** 标签栏底部空白高度（iPhoneX下为34）*/
#define TABBAR_SAFEAREA_HEIGHT (IS_iPhoneX ? 34 : 0)

/** 标签栏高度 */
#define TABBAR_HEIGHT 49

/** 工具栏高度 */
#define TOOLBAR_HEIGHT 49

/** 一般表视图内容高度 */
#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT - TABBAR_SAFEAREA_HEIGHT)



/** 黄金比例值 0.382+0.618=1   0.382/0.618=0.618   0.618/1=0.618 */
#define GOLD_SCALE_LONG(x)  (x * 0.618)
#define GOLD_SCALE_SHORT(x) (x * 0.382)

/** 单条分隔线高度，2x屏为1/2，3x屏为1/3 */
#define SINGLE_LINE_HEIGHT (1 / [UIScreen mainScreen].scale)
// 在非高清屏上，一个Point对应一个像素。为了防止“antialiasing”导致的奇数像素的线渲染时出现失真，你需要设置偏移0.5Point。在高清屏幕上，要绘制一个像素的线，需要设置线宽为0.5个Point，同时设置偏移为0.25 Point。此宏用在设置frame时在x或y轴偏移
#define SINGLE_LINE_ADJUST_OFFSET ((1 / [UIScreen mainScreen].scale) / 2)



#pragma mark -
#pragma mark Scale size (base iPhone6s plus iPad宽取plus宽)

#define SCALE(x) x * (SCREEN_WIDTH > 414 ? 414 : SCREEN_WIDTH) / 414



#pragma mark -
#pragma mark - NSLog

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(fmt, ...)
#endif

//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif



#pragma mark -
#pragma mark - AppDelegate
#define ZDAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate
#define ZDKeyWindow [UIApplication sharedApplication].keyWindow



#pragma mark -
#pragma mark - TICK、TOCK（代码耗时调试），也可以用YYBenchmark
#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"tick和tock之间耗时：%lf", - startTime.timeIntervalSinceNow);




#endif /* Macros_h */
