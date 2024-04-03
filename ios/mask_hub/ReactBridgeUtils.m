//
//  ReactBridgeUtils.m
//  app
//
//  Created by YingLin Xia on 2021/6/17.
//

#import "ReactBridgeUtils.h"

@implementation ReactBridgeUtils

static id _Utils;

static id _RCTBridge;

+ (ReactBridgeUtils*) shareInstance {
  if (nil == _Utils)
    _Utils = [[ReactBridgeUtils alloc] init];
  return _Utils;
}


- (void)createBridge: (NSURL*) jsCodeUrl launchOptions:(NSDictionary *) launchOptions {
  _RCTBridge = [[RCTBridge alloc] initWithBundleURL: jsCodeUrl moduleProvider: nil launchOptions: launchOptions];
}

- (RCTBridge*) getRCTBridge {
  if(nil == _RCTBridge) [self createBridge: nil launchOptions: nil];
  return _RCTBridge;
}

@end
