//
//  CodePushDownloadHandler.h
//  app
//
//  Created by YingLin Xia on 2021/6/7.
//

//NS_ASSUME_NONNULL_BEGIN

#import "MaskHubErrorUtils.h"

@interface FileDownloadHandler : NSObject <NSURLConnectionDelegate>

@property (strong) NSOutputStream *outputFileStream;
@property long long expectedContentLength;
@property long long receivedContentLength;
@property dispatch_queue_t operationQueue;
@property (copy) void (^progressCallback)(long long, long long);
@property (copy) void (^doneCallback)(BOOL);
@property (copy) void (^failCallback)(NSError *err);
@property NSString *downloadUrl;

- (id)init:(NSString *)downloadFilePath
operationQueue:(dispatch_queue_t)operationQueue
progressCallback:(void (^)(long long, long long))progressCallback
doneCallback:(void (^)(BOOL))doneCallback
failCallback:(void (^)(NSError *err))failCallback;

- (void)download:(NSString*)url;

@end


//NS_ASSUME_NONNULL_END
