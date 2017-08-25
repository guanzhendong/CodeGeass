//
//  DebugHelper.h
//  EVClub
//
//  Created by Eddit on 16/5/14.
//  Copyright (c) 2015年 ECLite. All rights reserved.
//

#import "DebugHelper.h"
//#import "NSObject+BR.h"
#if TARGET_OS_IPHONE
#import <objc/runtime.h>
#import <objc/message.h>
#else
#import <objc/objc-class.h>
#endif
#import "AppDelegate.h"
#import <mach/mach.h>
#import "YYFPSLabel.h"


static char kEx_Object_EC;

@implementation NSObject (EC)
- (void)setExObject:(NSObject *)exObject
{
    objc_setAssociatedObject(self, &kEx_Object_EC,exObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSObject *)exObject
{
    return objc_getAssociatedObject(self, &kEx_Object_EC);
}
@end

@interface NSObject (MethodSwizzlingCategory)

+ (BOOL)swizzleMethod:(SEL)origSel
           withMethod:(SEL)altSel;
+ (BOOL)swizzleClassMethod:(SEL)origSel
           withClassMethod:(SEL)altSel;

@end
#ifdef DEBUG
extern NSString* logMemUsage(void);
#endif
@implementation NSObject (MethodSwizzlingCategory)

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod = class_getInstanceMethod(self, origSel);
    if (!origSel) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(altSel), [self class]);
        return NO;
    }
    
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, altSel));
    
    return YES;
}

+ (BOOL)swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
    Class c = object_getClass((id)self);
    return [c swizzleMethod:origSel withMethod:altSel];
}

@end


UIImage* (* ImageNamed_IMP)(Class,SEL,NSString*);
@interface UIImage(swizzle)
+ (UIImage*)evImageNamed:(NSString *)name;
@end


@implementation UIImage(swizzle)

+ (UIImage*)evImageNamed:(NSString *)name
{
    UIImage *image = ImageNamed_IMP([UIImage class],@selector(imageNamed:),name);
    image.accessibilityIdentifier = name;
    return image;
}
@end


@implementation NSObject(DebugHelper)

- (NSString *)nameWithInstance:(id)instance
{
    unsigned int numIvars = 0;
    NSString *key=nil;
    for(Class class = self.class;(class != nil && key == nil);class = class.superclass)
    {
        Ivar * ivars = class_copyIvarList(class, &numIvars);
        for(int i = 0; i < numIvars; i++) {
            Ivar thisIvar = ivars[i];
            const char *type = ivar_getTypeEncoding(thisIvar);
            NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
            if (![stringType hasPrefix:@"@"] || [stringType isEqualToString:@"@\"NSIndexPath\""]
                || ([stringType rangeOfString:@"<"]).location != NSNotFound) continue;
            if ((object_getIvar(self, thisIvar) == instance)) {
                key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
                break;
            }
        }
        free(ivars);
    }
    return key;
}
@end


@implementation UIView(ergodicAndSetFrame)
- (void)ergodicSubviewsWithBlock:(BOOL(^)(UIView *view))handler DeepLoop:(BOOL)deepLoop
{
    for(UIView *v in self.subviews)
    {
        if(deepLoop) [v ergodicSubviewsWithBlock:handler DeepLoop:deepLoop];
        BOOL r = handler(v);
        if(r) break;
    }
}
@end

static DebugHelper *globalInstance = nil;

@interface DebugHelper(){
    BOOL _debug;
}

@end

#define LONG_PRESS_DEBUG_TAG 987654
#define DOUBLE_FINGER_LONG_PRESS_DEBUG_TAG 987653
#define THEWINDOW ([UIApplication sharedApplication].keyWindow ?: ([[UIApplication sharedApplication] windows].count > 0?  [[UIApplication sharedApplication] windows][0] : nil))
#define DEEP
@interface DebugHelper()

@property(nonatomic, strong) NSDictionary *testDict;
@property(nonatomic, strong) UILabel *longPressLabel;
@property(nonatomic, strong) NSString *debugInfoPath;
@property(nonatomic, weak) UIView *lastView;
@property(nonatomic, strong) CAGradientLayer *borderLayer;
@property(nonatomic, strong) UILongPressGestureRecognizer *longPressGR;
@property(nonatomic, strong) UILongPressGestureRecognizer *doubleFingerLongPressGR;
@property(nonatomic, strong) UITextView *logView;
@property(nonatomic, strong) UIView *windowMainView;
@property(nonatomic, strong) NSString *logPath;

@end

@implementation DebugHelper

+ (void)setup
{
#ifdef DEBUG
//    NSLog(@"沙盒路径：%@",NSHomeDirectory());
    [[self sharedInstance] setDebug:YES];
    [((AppDelegate*)[UIApplication sharedApplication].delegate).window addSubview:[DebugHelper sharedInstance].debugLabel];
    [((AppDelegate*)[UIApplication sharedApplication].delegate).window addSubview:[DebugHelper sharedInstance].fpsLabel];
#endif
}
+ (DebugHelper *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalInstance = [[DebugHelper alloc] init];
#ifdef DEBUG
        [globalInstance initLogDebuger];
        NSLog(@"debugHelper = %p",globalInstance);
        /*
        NSString *server = StagingApiBase;
        if(server.length > 0) {
            globalInstance.server = server;
        }
         */
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:10];
        label.text = @" 测试 ";
        /*
        if([server hasPrefix:@"http://test.m.evclub.com"]) label.text = @"TEST";
        else if([server hasPrefix:@"http://dev.m.evclub.com"]) label.text = @"DEV";
         */
        /*
        if ([UIApplication sharedApplication].networkEnvironment.integerValue == ECNetworkEnvironmentInner) {
            label.text = @"内网";
        } else {
            label.text = @"外网";
        }
         */
        label.tag = 232121;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor redColor];
        label.layer.cornerRadius = 3;
        label.clipsToBounds = YES;
        [label sizeToFit];
//        [label setPositionPoint:CGPointMake(110, 4)];
        CGRect frame = label.frame;
        frame.origin.x = 110;
        frame.origin.y = 4;
        label.frame = frame;
        globalInstance.debugLabel = label;
        
        
        // ZD add
        YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 2, CGRectGetMinY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
        fpsLabel.backgroundColor = [UIColor redColor];
        globalInstance.fpsLabel = fpsLabel;
        // ---
        
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains (NSDesktopDirectory, NSUserDomainMask, YES);
        NSArray *path = [[paths objectAtIndex:0] componentsSeparatedByString:@"/"];
        NSString * desktopPath = [[[path[1] stringByAppendingPathComponent:path[2]] stringByAppendingPathComponent:@"Desktop"] stringByAppendingPathComponent:@"debugHelper.txt"];
        desktopPath = [@"/" stringByAppendingString:desktopPath];
        globalInstance.debugInfoPath = desktopPath;
        if([[NSFileManager defaultManager]fileExistsAtPath:desktopPath]) globalInstance.needLog = YES;
        //自定义imageNamed
        ImageNamed_IMP = (UIImage* (*)(Class,SEL,NSString*))[UIImage methodForSelector:@selector(imageNamed:)];
        SEL selector = NSSelectorFromString(@"evImageNamed:");
        [UIImage swizzleClassMethod:@selector(imageNamed:) withClassMethod:selector];
        
#endif
    });
    return globalInstance;
}

- (void)updateLabel
{
#ifdef DEBUG
    /*
    if ([UIApplication sharedApplication].networkEnvironment.integerValue == ECNetworkEnvironmentInner) {
         globalInstance.debugLabel.text = @"内网";
    } else {
         globalInstance.debugLabel.text = @"外网";
    }
     */
#endif
}


- (void)initLogDebuger
{
    //真机时将LOG输出到文件
    if(!globalInstance.logPath)
    {
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        path = [path stringByAppendingPathComponent:@"log"];
        globalInstance.logPath = path;
    }
    if (!isatty(STDERR_FILENO)) {
        NSString *path = globalInstance.logPath;
        if([[NSFileManager defaultManager] fileExistsAtPath:path]) [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        freopen([path cStringUsingEncoding:NSUTF8StringEncoding], "a+", stderr);
    }
    
    
}
-(void)setDebug:(BOOL)debug
{
    _debug = debug;
    if(_debug)
    {
        if(!_longPressGR)
        {
            UILongPressGestureRecognizer *r = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(debugLongPressed:)];
            r.exObject = @(LONG_PRESS_DEBUG_TAG);
            self.longPressGR = r;
        }
        if(!_doubleFingerLongPressGR)
        {
            UILongPressGestureRecognizer *r = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(debugDoubleFingerLongPressed:)];
            r.numberOfTouchesRequired = 2;
            r.exObject = @(DOUBLE_FINGER_LONG_PRESS_DEBUG_TAG);
            self.doubleFingerLongPressGR = r;
        }
        [THEWINDOW addGestureRecognizer:_longPressGR];
        [THEWINDOW addGestureRecognizer:_doubleFingerLongPressGR];
        
    }
    else
    {
        [THEWINDOW removeGestureRecognizer:_longPressGR];
        [THEWINDOW removeGestureRecognizer:_doubleFingerLongPressGR];
    }
}

NSString *cFloatString(CGFloat f)
{
    NSString *str = nil;
    if (fmodf(f, 1)==0) {str = [NSString stringWithFormat:@"%.0f",f];}
    else if (fmodf(f*10, 1)==0) {str = [NSString stringWithFormat:@"%.1f",f];}
    else {str = [NSString stringWithFormat:@"%.2f",f];}
    return str;
}
NSString* StringFromCGRect(CGRect rect)
{
    if(CGRectEqualToRect(rect, CGRectZero)) return NSStringFromCGRect(CGRectZero);
    else return [NSString stringWithFormat:@"{%@, %@, %@, %@}",cFloatString(rect.origin.x),cFloatString(rect.origin.y),cFloatString(rect.size.width),cFloatString(rect.size.height)];
}
-(void)debugDoubleFingerLongPressed:(UILongPressGestureRecognizer*)recognizer
{
    @autoreleasepool {
        UIWindow *window = THEWINDOW;
        static BOOL open;
        if( recognizer.state == UIGestureRecognizerStateBegan)
        {
            if (!window) {
                return;
            }
            if(!_logView)
            {
                self.windowMainView = [[UIView alloc] initWithFrame:CGRectMake(0, window.frame.size.height, window.frame.size.width, window.frame.size.height)];
                self.windowMainView.hidden = YES;
                [window insertSubview:_windowMainView atIndex:0];
                UITextView *logView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, window.frame.size.width, window.frame.size.height - 20)];
                [logView setContentInset:UIEdgeInsetsZero];
                logView.editable = NO;
                logView.alwaysBounceVertical = YES;
                logView.backgroundColor = [UIColor blackColor];
                logView.textColor = [UIColor lightGrayColor];
                logView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
                [_windowMainView addSubview:logView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refreshLogView)];
                self.logView = logView;
                [self.logView addGestureRecognizer:tap];
                
                UILongPressGestureRecognizer *r = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(debugDoubleFingerLongPressed:)];
                r.numberOfTouchesRequired = 2;
                r.exObject = @(DOUBLE_FINGER_LONG_PRESS_DEBUG_TAG);
                [self.logView addGestureRecognizer:r];

            }
            if(!open)
            {
                [self refreshLogView];
                open = YES;
                _windowMainView.hidden = NO;
                [window bringSubviewToFront:_windowMainView];
                [UIView animateWithDuration:0.3 animations:^{
                    _windowMainView.frame = CGRectMake(0, 0, _windowMainView.frame.size.width, _windowMainView.frame.size.height);
                }];
            }
            else
            {
                open = NO;
                [UIView animateWithDuration:0.3 animations:^{
                    _windowMainView.frame = CGRectMake(_windowMainView.frame.origin.x, _windowMainView.frame.size.height, _windowMainView.frame.size.width, _windowMainView.frame.size.height);
                } completion:^(BOOL finished) {
                    _windowMainView.hidden = YES;
                }];
            }
        }
        
    }
}
-(void)refreshLogView
{
    NSLog(@"refreshLogView");
    @autoreleasepool {
        NSString *content = [[NSString alloc]initWithContentsOfFile:_logPath encoding:NSUTF8StringEncoding error:nil];
        _logView.text = content;
        
        if (content.length > 0) {
            [_logView scrollRangeToVisible:NSMakeRange(content.length - 1, 1)];
        }
    }
}

-(void)debugLongPressed:(UILongPressGestureRecognizer*)recognizer
{
    @autoreleasepool {
        UIEvent *event = [[UIEvent alloc]init];
        UIEvent *e = (UIEvent*)[[event touchesForGestureRecognizer:recognizer] anyObject];
        CGPoint fingerPoint = [recognizer locationInView:THEWINDOW];
        UIView *view = [THEWINDOW hitTest:fingerPoint  withEvent:e];
        for(UIView *v in view.subviews)
        {
#ifdef DEEP
            if([v pointInside:[recognizer locationInView:v] withEvent:e])
#else
                if([v pointInside:[recognizer locationInView:v] withEvent:e] && v.userInteractionEnabled)
#endif
                {
                    view = v;
                    break;
                }
        }
        if(view != _lastView)
        {
            self.lastView = view;
            UIViewController *topController = [DebugHelper topMostController];
            UILabel *label = self.longPressLabel;
            if(recognizer.state != UIGestureRecognizerStateCancelled && recognizer.state != UIGestureRecognizerStateEnded)
            {
                CGRect frameBottom = CGRectMake(0,THEWINDOW.bounds.size.height - 80, THEWINDOW.bounds.size.width, 80);
                CGRect frameUp = CGRectMake(0,[UIApplication sharedApplication].statusBarFrame.size.height, THEWINDOW.bounds.size.width, 80);
                if(!label)
                {
                    label = [[UILabel alloc]initWithFrame:CGRectZero];
                    label.font = [UIFont systemFontOfSize:14];
                    label.tag = LONG_PRESS_DEBUG_TAG;
                    label.adjustsFontSizeToFitWidth = YES;
                    label.numberOfLines = 10;
                    label.textAlignment = NSTextAlignmentLeft;
                    label.backgroundColor = [UIColor lightGrayColor];
                    label.layer.borderColor = [UIColor grayColor].CGColor;
                    label.layer.borderWidth = 0.5;
                    label.frame = frameBottom;
                    if(fingerPoint.y > [UIScreen mainScreen].bounds.size.height * 0.85) {
                        [label setFrame:frameUp];
                    }
                    if(fingerPoint.y < [UIScreen mainScreen].bounds.size.height * 0.15) {
                        [label setFrame:frameBottom];
                    }
                    self.longPressLabel = label;
                }
                if(!_borderLayer)
                {
                    self.borderLayer = [self createGradientBorderLayer];
                }
                [UIView animateWithDuration:0.2 animations:^{
                    if(fingerPoint.y > [UIScreen mainScreen].bounds.size.height * 0.85) {
                        [label setFrame:frameUp];
                    }
                    if(fingerPoint.y < [UIScreen mainScreen].bounds.size.height * 0.15) {
                      [label setFrame:frameBottom];
                    }
                }];
                __block NSString *varName = [topController nameWithInstance:view];
                __block NSString *varNameS = [topController nameWithInstance:view.superview];
                if(!varNameS) varNameS = [NSString stringWithFormat:@"%p",view.superview];
                if(!varName) varName = [NSString stringWithFormat:@"%p",view];
                NSString *tipS = [NSString stringWithFormat:@"(S)<%@:%@>: %@",NSStringFromClass(view.superview.class),varNameS,StringFromCGRect(view.superview.frame)];
                NSString *tip = [NSString stringWithFormat:@"<%@:%@>: %@",NSStringFromClass(view.class),varName,StringFromCGRect(view.frame)];
                tip = [tip stringByAppendingString:[self detailMessageWithView:view]];
                tipS = [tipS stringByAppendingString:[self detailMessageWithView:view.superview]];
                UIViewController *controller = view.viewController;
                NSString *parentViewController = @"";
                if(controller)
                {
                    parentViewController = [NSString stringWithFormat:@"%@\n",NSStringFromClass(controller.class)];
                }
#ifdef DEBUG
                label.text = [NSString stringWithFormat:@"%@%@\n%@\n%@",parentViewController,tip,tipS,logMemUsage()];
#else
                label.text = [NSString stringWithFormat:@"%@%@\n%@\n",parentViewController,tip,tipS];
#endif
                if(_needLog) {
                    [label.text writeToFile:_debugInfoPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }
                [THEWINDOW addSubview:label];
                CGPoint point = [view.superview convertPoint:view.frame.origin toView:nil];
                CGRect theFrame = CGRectMake(point.x, point.y, view.frame.size.width, view.frame.size.height);
                [_borderLayer setFrame:theFrame];
                [_borderLayer setBounds:CGRectMake(0,0, view.frame.size.width, view.frame.size.height)];
                [_borderLayer.mask setFrame:_borderLayer.bounds];
                [_borderLayer.mask setBounds:_borderLayer.bounds];
                [THEWINDOW.layer addSublayer:_borderLayer];
            }
            else
            {
                [label removeFromSuperview];
                [_borderLayer removeFromSuperlayer];
                self.borderLayer = nil;
            }
        }
        if(recognizer.state == UIGestureRecognizerStateCancelled ||
           recognizer.state == UIGestureRecognizerStateEnded ||
           recognizer.state == UIGestureRecognizerStateFailed)
        {
            self.lastView = nil;
            UILabel *label = self.longPressLabel;
            [label removeFromSuperview];
            [_borderLayer removeFromSuperlayer];
            self.borderLayer = nil;
            
        }
    }
}
-(NSString*)detailMessageWithView:(UIView*)view
{
    NSString *message = @"";
    if([view isKindOfClass:[UIControl class]])
    {
        UIButton *btn = (UIButton*)view;
        for(NSObject *target in btn.allTargets)
        {
            NSArray *actions = [btn actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
            if(actions.count > 0)
            {
                message = [message stringByAppendingFormat:@"\nClick:[%@ %@]",NSStringFromClass(target.class),actions[0]];
            }
        }
    }
    if([view isKindOfClass:[UIImageView class]])
    {
        UIImage *image = [(UIImageView*)view image];
        
        if(image.accessibilityIdentifier)
        {
            message = [message stringByAppendingFormat:@"\nimageNamed:%@",image.accessibilityIdentifier];
        }
    }
    
    return message;
}
+ (UIViewController*)topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    if ([topController isKindOfClass:[UINavigationController class]])
    {
        topController = [(UINavigationController*)topController topViewController];
    }
    return topController;
}
- (CAGradientLayer*)createGradientBorderLayer
{
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];
    gradientLayer.masksToBounds = YES;
    NSMutableArray *colorArray = [NSMutableArray array];
    for(NSInteger hue = 0;hue<=360;hue+=5)
    {
        [colorArray addObject:(id)[UIColor colorWithHue:hue/360.0 saturation:1 brightness:1 alpha:1].CGColor];
    }
    [gradientLayer setColors:colorArray];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.borderWidth = 1;
    gradientLayer.mask = maskLayer;
    CAKeyframeAnimation *animationStartPoint = [CAKeyframeAnimation animationWithKeyPath:@"startPoint"];
    animationStartPoint.duration = 2;
    animationStartPoint.repeatCount = HUGE_VALF;
    animationStartPoint.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                                   [NSValue valueWithCGPoint:CGPointMake(1, 0)],
                                   [NSValue valueWithCGPoint:CGPointMake(1, 1)],
                                   [NSValue valueWithCGPoint:CGPointMake(0, 1)],
                                   [NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    CAKeyframeAnimation *animationEndPoint = [CAKeyframeAnimation animationWithKeyPath:@"endPoint"];
    animationEndPoint.duration = 2;
    animationEndPoint.repeatCount = HUGE_VALF;
    animationEndPoint.values = @[[NSValue valueWithCGPoint:CGPointMake(1, 1)],
                                 [NSValue valueWithCGPoint:CGPointMake(0, 1)],
                                 [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                                 [NSValue valueWithCGPoint:CGPointMake(1, 0)],
                                 [NSValue valueWithCGPoint:CGPointMake(1, 1)]];
    
    [gradientLayer addAnimation:animationStartPoint forKey:nil];
    [gradientLayer addAnimation:animationEndPoint forKey:nil];
    return gradientLayer;
}

+ (void)showMemoryUseage
{
#ifdef DEBUG
    NSLog(@"%@",logMemUsage());
#endif
}

@end
#ifdef DEBUG
vm_size_t usedMemory(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = MACH_TASK_BASIC_INFO_COUNT;
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0; // size in bytes
}

vm_size_t freeMemory(void) {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return vm_stat.free_count * pagesize;
}

NSString* logMemUsage(void) {
    @autoreleasepool {
        
        
        // compute memory usage and log if different by >= 100k
        static long prevMemUsage = 0;
        long curMemUsage = usedMemory();
        long memUsageDiff = curMemUsage - prevMemUsage;
        
        //    if (memUsageDiff > 100000 || memUsageDiff < -100000)
        {
            prevMemUsage = curMemUsage;
        }
        CGFloat logUseageMem = curMemUsage/1024.0f;
        CGFloat logDiffMem = memUsageDiff/1024.0f;
        CGFloat logFreeMem =  freeMemory()/1024.0f;
        
        NSString *log = [NSString stringWithFormat:@"内存使用 %.2f MB(%7.1f kb (%+5.0f kb)), 剩余 %.2f MB(%7.1f kb)",logUseageMem/1024.0f ,logUseageMem,logDiffMem,logFreeMem/1024.0f,logFreeMem];
        return log;
    }
}
#endif
