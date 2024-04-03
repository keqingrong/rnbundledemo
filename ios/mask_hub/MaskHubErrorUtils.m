//
//  MaskHubErrorUtils.m
//  app
//
//  Created by YingLin Xia on 2021/6/7.
//

#import "MaskHubErrorUtils.h"

@implementation MaskHubErrorUtils

static NSString *const MaskhubErrorDomain = @"MaskHubError";
static const int MaskHubErrorCode = -1;

+ (NSError *)errorWithMessage:(NSString *)errorMessage {
    return [NSError errorWithDomain: MaskhubErrorDomain
                               code: MaskHubErrorCode
                           userInfo: @{ NSLocalizedDescriptionKey: NSLocalizedString(errorMessage, nil) }];
}


//+ (BOOL)isCodePushError:(NSError *)err {
//    return err != nil && [MaskhubErrorDomain isEqualToString:err.domain];
//}


@end
