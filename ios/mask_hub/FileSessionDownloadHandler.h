//
//  FileSessionDownloadHandler.h
//  app
//
//  Created by YingLin Xia on 2021/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileSessionDownloadHandler : NSObject<NSURLSessionDelegate>

-(void)download:(NSString*) url complete:(void(^)(BOOL success,NSString* path)) downloadCompleteHandler;

@end

NS_ASSUME_NONNULL_END
