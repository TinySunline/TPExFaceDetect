//
//  TPExFaceDetect.h
//  Pods
//
//  Created by kingdomrain on 2017/2/8.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@protocol TPFaceDetectProtocol<JSExport>
@property(nonatomic, strong) JSValue *success;
@property(nonatomic, strong) JSValue *error;

-(void)start;

@end

@interface TPExFaceDetect : NSObject<TPFaceDetectProtocol>
@property(nonatomic,strong) UIViewController *viewController;
@property (nonatomic, strong) NSArray *liveDetectTypes;


@end
