//
//  TPExFaceDetect.m
//  Pods
//
//  Created by kingdomrain on 2017/2/8.
//
//

#import "TPExFaceDetect.h"
#import <HTJCFaceLiveDetectSdk/THIDMCHTJCViewManger.h>


@implementation TPExFaceDetect
@synthesize error;
@synthesize success;


-(id)init
{
    if(self = [super init]) {
        self.viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return self;
}

-(void)start{
    NSLog(@"开始人脸识别");
    [self setDetect];
}

-(void)setDetect {
    
    THIDMCHTJCViewManger *manager = [THIDMCHTJCViewManger sharedManager:self.viewController];
//    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray *detectTypes = @[@1, @0, @2, @1];
    if (self.liveDetectTypes.count != 0) {
        detectTypes = self.liveDetectTypes;
    }
    
    //是否随机
    BOOL isRandom = [[detectTypes lastObject] boolValue];
    if (detectTypes.count == 4) {
        detectTypes = @[detectTypes[0], detectTypes[1], detectTypes[2]];
    } else if (detectTypes.count == 3) {
        detectTypes = @[detectTypes[0], detectTypes[1]];
    } else if (detectTypes.count == 2) {
        detectTypes = @[detectTypes[0]];
    } else {
        detectTypes = nil;
    }
    
    [manager navigationType:0];
    [manager isNeedRandom:isRandom];
    [manager liveDetectTypeArray:detectTypes];
    
    [manager getLiveDetectCompletion:^(BOOL sueccess, NSData *imageData) {
        [manager dismissTakeCaptureSessionViewController];
        UIImage *image = [UIImage imageWithData:imageData];
        //        [self.faceView changeToSuccessView:image];
        //        _naviTitleLb.text = @"检测结果";
        //图片对比  底层完成图片对比
        [self.success callWithArguments:@[@"成功"]];
        
    }
                              cancel:^(BOOL sueccess, NSString *error) {
                                  [self.error callWithArguments:@[@"取消"]];
                              }
                              failed:^(NSString *error) {
                                  if(error) {
                                      [self.error callWithArguments:@[error]];
                                  }
                              }];
}



@end
