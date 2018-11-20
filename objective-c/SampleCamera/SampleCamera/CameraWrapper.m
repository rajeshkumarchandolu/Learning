//
//  CameraWrapper.m
//  AbbYYDemo
//
//  Created by Konymp on 01/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import "CameraWrapper.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVCaptureVideoDataOutput.h>

#pragma mark Class PreiewLayer
@interface PreviewLayer : AVCaptureVideoPreviewLayer
    
    @end


@implementation PreviewLayer
    
-(instancetype) init{
    self = [super init];
    if(self){
        
    }
    return self;
}
    
    @end

#pragma mark Class CameraWraper


@interface CameraWrapper() {
    
    UIViewController *viewController;
    UIView *view;
    AVCaptureSession *avSession;
    dispatch_queue_t cameraFramesRetreivalQueue;
}
    
    @end

@implementation CameraWrapper
    
    - (instancetype)init
    {
        self = [super init];
        if (self) {
            //
        }
        return self;
    }
    
    -(instancetype) initWithViewController :(UIViewController*) viewController  WithView :(UIView*) view{
        self =[super init];
        if(self){
            self->viewController = viewController;
            self->view = view;
            
            //create the Camera Queue
            cameraFramesRetreivalQueue = dispatch_queue_create("CameraWrapperQueue", DISPATCH_QUEUE_CONCURRENT);
        }
        return self;
    }
    
    - (void)showCamera{
        
        [self requestCameraAcess];
        
    }
    
    
    
#pragma mark SampleBufferData Delegate Method
    - (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
      
        if(_cameraDelegate != nil){
            [_cameraDelegate captureOutput:output didOutputSampleBuffer:sampleBuffer fromConnection:connection];
        }
        
    }
    
    
    
    
#pragma mark privateMethods
    
    
    -(void) requestCameraAcess{
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                //createSession
                [self createSession];
            }else{
                //creation of alert
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                               message:@"Cannot proceed further as acess is not provided"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                [alert addAction:defaultAction];
                [self->viewController presentViewController:alert animated:NO completion:nil];
                
            }
        }];
    }
    
    -(Boolean) checkCameraAcess{
        AVAuthorizationStatus status =  [AVCaptureDevice  authorizationStatusForMediaType:AVMediaTypeVideo ];
        
        //creation of alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                       message:@"This is an alert."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        
        //boolean for status
        Boolean isCameraisAllowedToUSe = false;
        switch (status) {
            case AVAuthorizationStatusDenied :
            [alert setMessage:@"please provide acess without it we cannot proceed further"];
            isCameraisAllowedToUSe = true;
            break;
            case AVAuthorizationStatusAuthorized :
            //do nothing acess is provided;
            break;
            case AVAuthorizationStatusRestricted :
            [alert setMessage:@"User is not allowed to acess the camera "];
            break;
            case AVAuthorizationStatusNotDetermined :
            [alert setMessage:@"user has not yet granted or denied such permission."];
            break;
            default:
            break;
        }
        
        if(!isCameraisAllowedToUSe){
            [viewController presentViewController:alert animated:YES completion:nil];
            return false;
        }else{
            return true;
        }
        
    }
    -(void) createSession{
        
        AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
        
        AVCaptureInput *sessionInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil ];
        avSession = [[AVCaptureSession  alloc] init];
        
        //create a output with Delegate
        AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    
        [videoOutput setSampleBufferDelegate:self queue:self->cameraFramesRetreivalQueue];
        
        videoOutput.videoSettings = @{
                          (id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA)
                          };
        //configuring the presets of the avsession
        [avSession setSessionPreset:AVCaptureSessionPreset1920x1080];
        
        //adding the input and output of the Avsession
        [avSession addInput:sessionInput];
        [avSession addOutput:videoOutput];
        
        //creating a preview layer
        
        PreviewLayer *layer = [[PreviewLayer alloc] init];
        
        [layer setSession:avSession];
        
        if(view == nil){
            layer.frame = [viewController.view bounds];
            //add to the viewContoller view
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->viewController.view.layer addSublayer:layer];
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                layer.frame = [self->view bounds];
                [self->viewController.view.layer addSublayer:layer];
            });
            
        }
        [avSession startRunning];
    }
    
   
    
    @end


