//
//  CameraWrapper.h
//  AbbYYDemo
//
//  Created by Konymp on 01/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CameraDelegate <AVCaptureVideoDataOutputSampleBufferDelegate>
    
    @end

@interface CameraWrapper : AVCaptureVideoPreviewLayer <AVCaptureVideoDataOutputSampleBufferDelegate>
    
    @property id<CameraDelegate> cameraDelegate;
    
    -(instancetype) initWithViewController:(UIViewController*) viewController  WithView: (UIView* __nullable)  view;
    
    -(void) showCamera;

@end






NS_ASSUME_NONNULL_END
