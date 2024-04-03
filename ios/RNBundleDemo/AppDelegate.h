//#import <React/RCTBridgeDelegate.h>
//#import <UIKit/UIKit.h>
//
//@interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate>
//
//@property (nonatomic, strong) UIWindow *window;
//
//@end

//#import <React/RCTBridgeDelegate.h>
#import <UIKit/UIKit.h>
#import "MaskHub.h"

//@interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@end

@interface MinAppVersionChecker : NSObject<VersionCheckerDelegate>

@end
