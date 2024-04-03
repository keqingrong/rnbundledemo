//#import "AppDelegate.h"
//
//#import <React/RCTBridge.h>
//#import <React/RCTBundleURLProvider.h>
//#import <React/RCTRootView.h>
//
//#ifdef FB_SONARKIT_ENABLED
//#import <FlipperKit/FlipperClient.h>
//#import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
//#import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
//#import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
//#import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
//#import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>
//
//static void InitializeFlipper(UIApplication *application) {
//  FlipperClient *client = [FlipperClient sharedClient];
//  SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
//  [client addPlugin:[[FlipperKitLayoutPlugin alloc] initWithRootNode:application withDescriptorMapper:layoutDescriptorMapper]];
//  [client addPlugin:[[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
//  [client addPlugin:[FlipperKitReactPlugin new]];
//  [client addPlugin:[[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
//  [client start];
//}
//#endif
//
//@implementation AppDelegate
//
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//#ifdef FB_SONARKIT_ENABLED
//  InitializeFlipper(application);
//#endif
//
//  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
//  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
//                                                   moduleName:@"RNBundleDemo"
//                                            initialProperties:nil];
//
//  if (@available(iOS 13.0, *)) {
//      rootView.backgroundColor = [UIColor systemBackgroundColor];
//  } else {
//      rootView.backgroundColor = [UIColor whiteColor];
//  }
//
//  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//  UIViewController *rootViewController = [UIViewController new];
//  rootViewController.view = rootView;
//  self.window.rootViewController = rootViewController;
//  [self.window makeKeyAndVisible];
//  return YES;
//}
//
//- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
//{
//#if DEBUG
//  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
//#else
//  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
//#endif
//}
//
//@end


#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

#ifdef FB_SONARKIT_ENABLED
#import <FlipperKit/FlipperClient.h>
#import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
#import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
#import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
#import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
#import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPSessionManager.h>

#import "LoadReactViewController.h"
#import "ReactBridgeUtils.h"

static void InitializeFlipper(UIApplication *application) {
  FlipperClient *client = [FlipperClient sharedClient];
  SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
  [client addPlugin:[[FlipperKitLayoutPlugin alloc] initWithRootNode:application withDescriptorMapper:layoutDescriptorMapper]];
  [client addPlugin:[[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
  [client addPlugin:[FlipperKitReactPlugin new]];
  [client addPlugin:[[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
  [client start];
}
#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef FB_SONARKIT_ENABLED
  InitializeFlipper(application);
#endif
  
  //  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  //  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
  //                                                   moduleName:@"app"
  //                                            initialProperties:nil];
  //
  //  if (@available(iOS 13.0, *)) {
  //      rootView.backgroundColor = [UIColor systemBackgroundColor];
  //  } else {
  //      rootView.backgroundColor = [UIColor whiteColor];
  //  }
  //
  //  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  //  UIViewController *rootViewController = [UIViewController new];
  //  rootViewController.view = rootView;
  //  self.window.rootViewController = rootViewController;
  //  [self.window makeKeyAndVisible];
  
  
  
  self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
  
  [[ReactBridgeUtils shareInstance] createBridge: nil launchOptions: launchOptions];
  NSString * contextDir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent: @"mask_hub"];
  [[Options shareInstance] contextDir: contextDir];                                      // bundle模块储存路径
  [[Options shareInstance] debug: DEBUG];                                                // 是否启用debug模式
  [[Options shareInstance] launchOptions: launchOptions];                                // 启动参数
  [Options shareInstance].versionCheckDelegate = [[MinAppVersionChecker alloc] init];  // 对接苏宁等第三方发布平台
  
  
  Page* page = [[Page alloc] init];
  [page name: @"app"];
  [page url: @"rn://app/index.ios.jsbundle"];
  
  [page setValue:@"storeCode" keyOf:@"240112"];


  
  self.window.rootViewController = [[LoadReactViewController alloc] initWithPage: page];
  [self.window makeKeyAndVisible];
  return YES;
}

//- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
//{
//#if DEBUG
//  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
//#else
//  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
//#endif
//}

@end



@implementation MinAppVersionChecker

- (void) requestRemoteBundleVersion: (NSDictionary*) request result: (void(^)(BOOL success, BundleEntity* result)) callback {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  [manager GET:@"https://tuicr.oss-cn-hangzhou.aliyuncs.com/jsbundle/demo/data.json" parameters: nil headers: nil progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSDictionary* obj = (NSDictionary *)responseObject;
    NSDictionary* result = obj[@"data"];
    
    if(nil != result) {
      BundleEntity* entity = [[BundleEntity alloc] init];
      entity.url = result[@"ossUrl"];
      entity.verifyCode = result[@"md5code"];
      entity.version = result[@"version"];
      callback(SUCCESS, entity);
    } else {
      callback(SUCCESS, nil);
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    callback(FAILURE, nil);
    
  }];
}

- (BundleEntity*) lastVersion: (NSString*) bundleKey {
  return [[NSUserDefaults standardUserDefaults] valueForKey: bundleKey];
}

- (void) setValue:(BundleEntity *)value keyOf:(NSString *)bundleKey {
  [[NSUserDefaults standardUserDefaults] setValue: value forKey: bundleKey];
}

- (BOOL) checkWithLastVersion: (BundleEntity*) lastVersion remoteVersion: (BundleEntity*) remoteNewVersion {
  if(nil != lastVersion || nil != remoteNewVersion) return YES;
  NSString* oVer = [lastVersion version];
  NSString* nVer = [remoteNewVersion version];
  return oVer != nVer;
}

@end
