//
//  LoadReactViewController.h
//  app
//
//  Created by YingLin Xia on 2021/6/7.
//

#import <Foundation/Foundation.h>
//#import <React/RCTBridgeDelegate.h>

#import <UIKit/UIKit.h>
#import <React/RCTRootView.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcherProtocol.h>
#import <React/RCTBundleURLProvider.h>

#import "Disget.h"
#import "MaskHubErrorUtils.h"
#import "ReactBridgeUtils.h"
#import "MaskHub.h"

//@interface LoadReactViewController : UIViewController<RCTBridgeDelegate>
@interface LoadReactViewController : UIViewController

- (instancetype)initWithPage:(Page *)page;


@end


