//
//  MaskHub.m
//  app
//
//  Created by YingLin Xia on 2021/6/7.
//

#import "MaskHub.h"


@implementation Page

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.extras = [[NSMutableDictionary alloc] init];
  }
  return self;
}

- (void)name:(NSString *)name {
  self.name = name;
}

- (void) url:(NSString *)url {
  self.url = url;
}

- (void) setValue:(NSObject *)value keyOf:(NSString *) key {
  if(nil == self.extras) {
    self.extras = [[NSMutableDictionary alloc] init];
  }
  [self.extras setValue: value forKey: key];
}

- (NSString *) getUrl {
  return self.url;
}


- (NSString *) getName {
  return self.name;
}

- (NSDictionary *) getExtras {
  return self.extras;
}

- (NSString *) filePath {
  if(nil == self.url) return nil;
  NSString* p = @"://";
  NSUInteger len = [p length];
  NSRange destRange = [self.url rangeOfString: p options: NSBackwardsSearch];
  if (destRange.location != NSNotFound) {
    NSString *result = [self.url substringFromIndex: destRange.location + len];
    NSLog(@"%@",result);
    return  result;
  } else {
    return self.url;
  }
}


@end


@implementation Options

static id _Options;

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.debug = NO;
  }
  return self;
}

+ (Options*) shareInstance {
  if (!_Options)
    _Options = [[Options alloc] init];
  return _Options;
}

- (void) contextDir:(NSString *)contextDir {
//  self.appKey = appKey;
  
  self.contextDir = [contextDir hasSuffix: @"/"] ? contextDir : [contextDir stringByAppendingString: @"/"];
}
- (void) debug: (BOOL) debug{
  self.debug = debug;
  
  
}


- (void) launchOptions: (NSDictionary*)launchOptions{
  self.launchOptions = launchOptions;
}

//- (instancetype)init {
//  self = [super init];
//  if (self) {
//  }
//  return self;
//}

@end

@implementation BundleEntity
@end
