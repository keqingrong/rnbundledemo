//
//  MaskHubErrorUtils.h
//  app
//
//  Created by YingLin Xia on 2021/6/7.
//

#import <Foundation/Foundation.h>


@interface MaskHubErrorUtils : NSObject

+ (NSError *)errorWithMessage:(NSString *)errorMessage;

//+ (BOOL)isCodePushError:(NSError *)error;

@end

