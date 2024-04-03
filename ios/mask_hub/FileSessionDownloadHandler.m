//
//  FileSessionDownloadHandler.m
//  app
//
//  Created by YingLin Xia on 2021/6/7.
//

#import "FileSessionDownloadHandler.h"

@implementation FileSessionDownloadHandler


-(void)download:(NSString*) downloadUrl complete:(void(^)(BOOL success, NSString* path)) completeHandler {
  //  if([ScriptLoadUtil isScriptLoaded:moduleName]){
  //    downloadCompleteHandler(YES,nil);
  //    return;
  //  }
  NSURL *url = [NSURL URLWithString: downloadUrl];
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDownloadTask *downloadTask =
  [session downloadTaskWithURL:url
             completionHandler: ^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if(nil != error) {
      NSLog(@"download failure %@",error.localizedFailureReason);
      completeHandler(NO, nil);
      return ;
    }
    
    //location 下载到沙盒的地址
    NSLog(@"download success %@", location);
    NSString* tempDir = NSTemporaryDirectory();
//    NSString* subDir = [@"mask_hub" stringByAppendingPathComponent: response.suggestedFilename];
//    NSString * desPath = [tempDir stringByAppendingPathComponent: subDir];
//    NSString * desPathDir = [tempDir stringByAppendingPathComponent: @"mask_hub"];
    NSString * desPath = [tempDir stringByAppendingPathComponent: response.suggestedFilename];
    NSLog(@"download path: %@",desPath);
    
    //获取文件管理器
    NSFileManager * mgr = [NSFileManager defaultManager];
//    [mgr createDirectoryAtPath: desPathDir withIntermediateDirectories: YES attributes: nil error: nil];
    NSURL* desUrl =  [NSURL fileURLWithPath: desPath];
    NSError* moveError = nil;
    [mgr removeItemAtURL: desUrl error:nil];
    [mgr moveItemAtURL: location toURL: desUrl error: &moveError];
    if(nil != moveError) {
      NSLog(@"save file failure %ld", moveError.code);
      if(516 != moveError.code) {
        completeHandler(NO,nil);
        return;
      }
    }
    completeHandler(YES, desPath);
  }];
  [downloadTask resume];
}
@end
