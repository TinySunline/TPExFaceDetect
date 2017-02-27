//
//  TPExFaceDetect.m
//  Pods
//
//  Created by kingdomrain on 2017/2/8.
//
//

#import "TPExFaceDetect.h"
#import <HTJCFaceLiveDetectSdk/THIDMCHTJCViewManger.h>
#import "YZFAFNetworking.h"


@implementation TPExFaceDetect
@synthesize personalName;
@synthesize identityCardNo;
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
//        //人脸识别获得图片资源
//        UIImage *image = [UIImage imageWithData:imageData];
//        //图片对比  底层完成图片对比
//        //NSData *imageDatabb = UIImageJPEGRepresentation(image, 1.0);
//        //        然后应用Base64编码将其转换成base64编码的字符串：
//        //NSString *encodedString1 = [imageData base64Encoding];
//        
//        NSString *encodedString1 = [imageData base64EncodedStringWithOptions:0];
//        
//        //身份证获得的图片资源    识别获得图片资源
//        // 本地沙盒目录
//        NSString *pathaa = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
//        NSString *imageFilePathaa = [pathaa stringByAppendingPathComponent:@"/faceImage.jpg"];
//        UIImage *imageaa = [UIImage imageWithContentsOfFile:imageFilePathaa];
//        NSLog(@"image2 is size %@",NSStringFromCGSize(imageaa.size));
//        //        NSData *dataaa = [NSData dataWithContentsOfURL:[NSURL  URLWithString:imageFilePathaa]];
//        //        UIImage *imageaa = [UIImage imageWithData:dataaa]; // 取得图片
//        NSData *imageaaData = UIImageJPEGRepresentation(imageaa, 0.2);
//        NSString *encodedString2 = [imageaaData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        
//       
//        //发起网络请求
//        YZFAFHTTPSessionManager *manager = [YZFAFHTTPSessionManager manager];
//        manager.requestSerializer = [AFHTTPRequestSerializer  serializer];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"application/xml",@"text/json",@"text/javascript",@"text/xml",@"text/plain",  nil]];
//        [manager.requestSerializer setTimeoutInterval:20];
//        
//        // 拼接请求参数
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        params[@"username"] = @"test";
//        params[@"password"] = @"test";
//        params[@"encoding"] = @"utf-8";
//        [manager POST:@"http://cloud.exocr.com/face" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            [formData appendPartWithFileData:imageData name:@"face1" fileName:@"face1.jpg" mimeType:@"image/jpg"];
//            [formData appendPartWithFileData:imageaaData name:@"face2" fileName:@"face2.jpg" mimeType:@"image/jpg"];
//            
//        } progress:^(NSProgress * _Nonnull uploadProgress) {
//            ;
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"request url =%@\n request dic = %@",task.response.URL ,params);
//            NSLog(@"response = \n%@",responseObject);
//            NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions
//                                                                  error:nil];
//            NSLog(@"json==%@",json);
//            if([json[@"Error"] isEqualToString:@"0"]){
//                
//                  NSString *score = json[@"Score"];
//                  NSString *th_high = json[@"th_high"];
//                
//                float scoreFloat =[score floatValue];
//                float th_highFloat =[th_high floatValue];
//                if (scoreFloat>=th_highFloat) {
//                    //发送公安的API请求
//                    YZFAFHTTPSessionManager *manager1 = [YZFAFHTTPSessionManager manager];
//                    manager1.requestSerializer = [AFHTTPRequestSerializer  serializer];
//                    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
//                    [manager1.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"application/xml",@"text/json",@"text/javascript",@"text/xml",@"text/plain",@"text/html",nil]];
//                    [manager1.requestSerializer setTimeoutInterval:20];
//                    NSMutableDictionary *aparams = [NSMutableDictionary dictionary];
//                    aparams[@"appId"] = @"96973102562410501";           //应用ID   96973102562410501
//                    aparams[@"appKey"] = @"ee6f9e25690e4e639d2bbb2f0715f6ee";          //应用Key  ee6f9e25690e4e639d2bbb2f0715f6ee
//                    aparams[@"personalName"] = self.personalName;   //个人姓名
//                    aparams[@"identityCardNo"] = self.identityCardNo; //身份证号
//                    //                aparams[@"encoding"] = @"utf-8";
//                    [manager1 POST:@"http://id.exocr.com/verify" parameters:aparams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//                        [formData appendPartWithFileData:imageData name:@"collectPhoto" fileName:@"collectPhoto" mimeType:@"image/jpg"];
//                    } progress:^(NSProgress * _Nonnull uploadProgress) {
//                        ;
//                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////                        NSLog(@"request url =%@\n request dic = %@",task.response.URL ,aparams);
////                        NSLog(@"response111 = \n%@",responseObject);
//                        NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers
//                                                                              error:nil];
//                        
//                        NSLog(@"json111===%@",json);
//                        NSString *code = json[@"code"];
//                        if([code isEqualToString:@"1001"]){
//                            //                        NSString *desc = json[@"entity"][@"desc"];
//                            NSString *score = json[@"entity"][@"score"];
//                            int intScore =[score intValue];
//                            if (intScore>40) {
//                                NSString *backData = [NSString stringWithFormat:@"{\"code\":\"%@\",\"desc\":\"%@\"}",@"0",@"系统判断为同一人"];
//                                [self.success callWithArguments:@[backData]];
//                                
//                            }
//                            else if(intScore>30&&intScore<=40){
//                                NSString *backData = [NSString stringWithFormat:@"{\"code\":\"%@\",\"desc\":\"%@\"}",@"2",@"不能确定是否为同人"];
//                                [self.success callWithArguments:@[backData]];
//                                
//                            }
//                            else if(intScore<=30)
//                            {
//                                NSString *backData = [NSString stringWithFormat:@"{\"code\":\"%@\",\"desc\":\"%@\"}",@"1",@"系统判断为不同人"];
//                                [self.success callWithArguments:@[backData]];
//                            }
//                        }
//                        else{
//                            NSString *backData = [NSString stringWithFormat:@"{\"code\":\"%@\",\"desc\":\"%@\"}",@"2",@"不能确定是否是同一个人"];
//                            [self.success callWithArguments:@[backData]];
//                        }
//                        
//                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                        NSLog(@"request url =%@\n request dic = %@",task.response.URL ,aparams);
//                        NSLog(@"error = \n%@",error.localizedDescription);
//                    }];
//   
//                }
//            }
//            else{
//                NSString *backData = [NSString stringWithFormat:@"{\"code\":\"%@\",\"desc\":\"%@\"}",@"2",@"不能确定是否是同一个人"];
//                [self.success callWithArguments:@[backData]];
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"request url =%@\n request dic = %@",task.response.URL ,params);
//            NSLog(@"error = \n%@",error.localizedDescription);
//        }];
        
        //方案二: 客户端将人脸识别的图片地址抛出，由服务端发起图片的对比
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        UIImage *exFaceImg =[UIImage imageWithData:imageData];    //身份证背面全图
        NSString *exFaceImgPath = [path stringByAppendingPathComponent:@"/exFaceImg.jpg"];
        BOOL success = [UIImageJPEGRepresentation(exFaceImg, 0.5) writeToFile:exFaceImgPath  atomically:YES];
        if(success){
            NSString *imgUrl=@"local://";
            imgUrl = [imgUrl stringByAppendingString:exFaceImgPath];
            NSString *bdata = [NSString stringWithFormat:@"{\"mMove\":\"%@\",\"mRezion\":\"%@\",\"imgPath\":\"%@\",\"isLivePassed\":\"%@\"}",@"",@"",imgUrl,@"true"];
            [self.success callWithArguments:@[bdata]];
        }
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
