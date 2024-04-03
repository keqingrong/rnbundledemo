//
//  MaskHub.h
//  app
//
//  Created by YingLin Xia on 2021/6/7.
//

#import <Foundation/Foundation.h>

static NSString *const IndexJSBundleName = @"indexJsBundle";
static NSString *const DefaultBundleFileName = @"index.ios.jsbundle";
static NSInteger const SUCCESS = 1;
static NSInteger const FAILURE = -1;


@interface Page : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSMutableDictionary* extras;

- (void) name: (NSString *) name;
- (void) url: (NSString *) url;
- (void) setValue:(NSObject *)value keyOf:(NSString *) key;

- (NSDictionary *) getExtras;
- (NSString *) getName;
- (NSString *) getUrl;
- (NSString *) filePath;

@end



@interface BundleEntity : NSObject

@property (nonatomic, strong) NSString* url;        // 远程下载地址
@property (nonatomic, strong) NSString* filePath;   // 本地存储地址
@property (nonatomic, strong) NSString* version;    // 本地版本信息
@property (nonatomic, strong) NSString* verifyCode; // 文件合法性验证码


@end



@protocol VersionCheckerDelegate<NSObject>

@required

- (void) requestRemoteBundleVersion: (NSDictionary*) request result: (void(^)(BOOL success, BundleEntity* result)) callback;

- (BundleEntity*) lastVersion: (NSString*) bundleKey;

- (void) setValue: (BundleEntity*) value keyOf: (NSString*) bundleKey ;

- (BOOL) checkWithLastVersion: (BundleEntity*) lastVersion remoteVersion: (BundleEntity*) remoteNewVersion;

@end



@interface Options : NSObject

@property (nonatomic, strong) NSDictionary* launchOptions;
@property (nonatomic, strong) NSString* contextDir;
@property BOOL debug;
@property (nonatomic, strong) id<VersionCheckerDelegate> versionCheckDelegate;

+ (Options*) shareInstance;

- (void) contextDir:(NSString*)contextDir;

- (void) debug: (BOOL) debug;

- (void) launchOptions: (NSDictionary*) launchOptions;

@end
