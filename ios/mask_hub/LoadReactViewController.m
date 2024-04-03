//
//  LoadReactViewController.m
//  app
//
//  Created by YingLin Xia on 2021/6/7.
//

#import "LoadReactViewController.h"

#import "FileSessionDownloadHandler.h"
#import <SSZipArchive.h>
#import "Disget.h"
#import "MaskHubErrorUtils.h"

@interface LoadReactViewController()
@property (nonatomic, strong) UIView* rctView;
@property (nonatomic, strong) RCTBridge* rctBridge;
@property (nonatomic, strong) Page* page;
@property (nonatomic, strong) UIActivityIndicatorView* loadingView;

@end

@implementation LoadReactViewController


- (instancetype)initWithPage:(Page *)page {
  if (self = [super init]) {
    self.page = page;
  }
  return self;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  //  [self initViews];
  
  NSString* name = [self.page getName];
  NSDictionary* initialProperties =  [[self page] getExtras];
  NSString* contextDir = [[Options shareInstance] contextDir];
  id<VersionCheckerDelegate> delegate = [[Options shareInstance] versionCheckDelegate];
  if(![self checkDelegateSelector: delegate]) {
    @throw [MaskHubErrorUtils errorWithMessage: @"checkDelegateSelector failure !!!"];
  }
  
  //  [self showLoading];
  NSDictionary* request = @{ @"pageName" : name };
  BundleEntity* lastLocalVersion = [delegate lastVersion: name];
  
  [delegate requestRemoteBundleVersion: request result:^(BOOL success, BundleEntity* remoteBundleVersion) {
    BOOL hasVersion = [delegate checkWithLastVersion: lastLocalVersion remoteVersion: remoteBundleVersion];                        // 是否有新版本
    NSString* indexJsBundle = [contextDir stringByAppendingPathComponent: [self.page filePath]];                                   // 从contextDir与Page中获取访问页面
    
    if(!hasVersion) {
      [self loadReactView: indexJsBundle initialProperties: initialProperties];
      return;
    }
    
    FileSessionDownloadHandler* downloadHandler = [[FileSessionDownloadHandler alloc] init];
    NSString* downloadUrl = [remoteBundleVersion url];
    [downloadHandler download: downloadUrl complete: ^(BOOL success, NSString * _Nonnull path) {
      if(!success) return;
      NSLog(@"download success %@", path);
      
      NSString* fileMD5Hash = [Disget md5HashOfFileAtPath: path];
      if(fileMD5Hash != remoteBundleVersion.verifyCode) {
        @throw [MaskHubErrorUtils errorWithMessage: @"file verify code is Bad!!!"];
      }
      
      // 有新版本 同时请求无异常
      @try {
        NSString* bundlePathDir = [self install: path];
        NSLog(@"JS_BUNDLE path %@", bundlePathDir);
        [self loadReactView: indexJsBundle initialProperties: initialProperties]; // 加载bundle
        
        [remoteBundleVersion setFilePath: bundlePathDir]; // 更新本地bundle index文件
        [delegate setValue: remoteBundleVersion keyOf: name]; // 更新最新版本
      } @catch (NSException *exception) {
        NSLog(@"ReactJS Bundle install failure: %@", exception);
      }
      //    [self dismissLoading];
    }];
  }];
}

/*
 jsbundle安装到指定路径
 */
- (NSString*) install: (NSString*) zipPath {
  NSString* contextDir = [[Options shareInstance] contextDir];
  NSFileManager * mgr = [NSFileManager defaultManager];
  NSString* bundlePathDir = [contextDir stringByAppendingPathComponent: [self.page getName]];
  [mgr removeItemAtPath: bundlePathDir error: nil];
  [mgr createDirectoryAtPath: contextDir withIntermediateDirectories: YES attributes: nil error: nil]; //创建context dir 目录
  [mgr createDirectoryAtPath: bundlePathDir withIntermediateDirectories: YES attributes: nil error: nil]; //创建bundle目录
  [SSZipArchive unzipFileAtPath: zipPath toDestination: bundlePathDir]; //解压缩到指定的路径
  
  [mgr removeItemAtPath: zipPath error: nil];  // 删除下载文件
  
  return bundlePathDir;
}


/*
 加载并显示react view
 */
- (void) loadReactView: (NSString*) indexJsBundle initialProperties: (NSDictionary*) properties {
  self.rctBridge = [self createBridge: indexJsBundle initialProperties: properties];
  [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
    self.rctView = [[RCTRootView alloc] initWithBridge: self.rctBridge moduleName: [self.page getName] initialProperties: properties];
    self.rctView.frame = self.view.bounds;
    self.rctView.backgroundColor = [UIColor whiteColor];
    [self setView: self.rctView];
  }];
}

/*
 创建 react native 加载
 */
- (RCTBridge*) createBridge: (NSString*) jsBundlePath initialProperties: (NSDictionary*) properties {
  NSDictionary* launchOptions = [[Options shareInstance] launchOptions];
  BOOL isDebug = [[Options shareInstance] debug];
  [[RCTBundleURLProvider sharedSettings] setEnableDev: isDebug];
  NSURL* jsCodeUrl = nil;
  if (isDebug) {
    //    [RCTBundleURLProvider sharedSettings].jsLocation = @"127.0.0.1";
    jsCodeUrl = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot: @"index" fallbackResource: nil];
  } else {
    jsCodeUrl = [NSURL fileURLWithPath: jsBundlePath];
  }
  return [[RCTBridge alloc] initWithBundleURL: jsCodeUrl moduleProvider: nil launchOptions: launchOptions];
}


/*
 初始化views
 */
- (void) initViews {
  self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
  self.loadingView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, 200);
  self.loadingView.color = [UIColor blueColor];
}


/*
 显示进度条
 */
- (void) showLoading {
  if(nil != self.loadingView) {
    [self.view addSubview: self.loadingView];
    [self.loadingView startAnimating];
  }
}

/*
  隐藏进度条
 */
- (void) dismissLoading {
  if(nil != self.loadingView) {
    [self.loadingView stopAnimating];
    [self.loadingView removeFromSuperview];
  }
}

/*
  判断delegate 的方法是否都被实现
 */
-(BOOL) checkDelegateSelector: (id<VersionCheckerDelegate>) delegate {
  return [delegate respondsToSelector: @selector(requestRemoteBundleVersion:result:)]
          && [delegate respondsToSelector: @selector(lastVersion:)]
          && [delegate respondsToSelector: @selector(setValue:keyOf:)]
          && [delegate respondsToSelector: @selector(checkWithLastVersion:remoteVersion:)];
}


@end
