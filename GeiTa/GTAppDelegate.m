//
//  GTAppDelegate.m
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import "GTAppDelegate.h"

@implementation GTAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef LSDEBUG
    NSLog(@"\n%@\n",NSHomeDirectory());
#endif
    
    messageCenter=[GTMessageCenter defaultCenter];
    
    [UIImage setIsRetina];//设置一个全局的屏幕变量
    [GTSave setUserDefaults];//设置全局的用户信息存储变量
    user=[GTUser currentUser];
    [user copyPreUser:[GTSave obtainUser]];//获取上次存储的用户信息
    [GTLocationManager start];//开始定位
    
    //启动网络监控
    [self startInternetMonitor];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark- 启动网络监视
- (void)startInternetMonitor
{
    //网络状态监控
    [messageCenter addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    //持续监视
    //监视服务器连通状况
    Reachability* hostReachability = [[Reachability reachabilityWithHostName:@"www.apple.com"] retain];
    [hostReachability startNotifier];
}

#pragma mark- 网络状态的监视方法
- (void)reachabilityChanged:(NSNotification*)notification//网络类型变化判断
{
    Reachability* reachability = notification.object;
    NSParameterAssert([reachability isKindOfClass: [Reachability class]]);
    switch ([reachability currentReachabilityStatus])
    {
        case NotReachable:
            GTLOG(@"当前无网络连接,通知来源于:%@",notification.name);
            break;
        case ReachableViaWiFi:
            GTLOG(@"当前连接WIFI,通知来源于:%@",notification.name);
            break;
        case ReachableViaWWAN:
            GTLOG(@"当前连接3G,通知来源于:%@",notification.name);
            break;
        default:
            GTLOG(@"当前有网络连接状态未知,通知来源于:%@",notification.name);
    }
    
    //只有在之前状态或者当前状态有一个为不连接的情况才发出通知
    NetworkStatus networkStatus=user.networkStatus;
    user.networkStatus=[reachability currentReachabilityStatus];
    if(networkStatus==NotReachable || [reachability currentReachabilityStatus]==NotReachable)
    {
        [messageCenter postNotificationName:LSNotificationNetworkStatusChanged object:nil];
    }
}

@end
