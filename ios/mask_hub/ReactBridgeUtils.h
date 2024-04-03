//
//  ReactBridgeUtils.h
//  app
//
//  Created by YingLin Xia on 2021/6/17.
//

#import <Foundation/Foundation.h>


#import <React/RCTRootView.h>
#import <React/RCTBridgeModule.h>

@interface ReactBridgeUtils : NSObject

+ (ReactBridgeUtils*) shareInstance;
- (void) createBridge: (NSURL*) jsCodeUrl launchOptions:(NSDictionary *) launchOptions;
- (RCTBridge*) getRCTBridge;

@end

