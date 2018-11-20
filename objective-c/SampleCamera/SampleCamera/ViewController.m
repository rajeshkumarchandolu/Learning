//
//  ViewController.m
//  SampleCamera
//
//  Created by Konymp on 30/10/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SamplePreviewClass.h"

@interface ViewController (){
    AVCaptureSession *session;
    AVCaptureDevice *camera;
    AVCaptureInput *videoInput;

    SamplePreviewClass *preview;
    
    dispatch_queue_t videoQueue;
    
    __weak IBOutlet UIView *previewView;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self requestAuthorizationAccess];
    
    preview = [[SamplePreviewClass alloc] init];
    preview.frame = previewView.bounds;
    [previewView.layer addSublayer:preview];
    const char *name = "VideoOuputQueue";
    videoQueue = dispatch_queue_create(name, DISPATCH_QUEUE_SERIAL);
    [self createCaptureSession];
    

    
    
}

-(void) createCaptureSession{
    

    session = [[AVCaptureSession alloc] init];
    //create the input
    AVCaptureDevice *cameraDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    AVCaptureInput *videoInput =[AVCaptureDeviceInput deviceInputWithDevice:cameraDevice error:nil];
    
    //create the output
    [preview setSession:session];
    
    //additon of the input to the session
    [session addInput:videoInput];
    
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoOutput setSampleBufferDelegate:self queue:videoQueue];
    [session addOutput:videoOutput];
    
    //preset
    [session setSessionPreset:AVCaptureSessionPreset1920x1080];
    
    
    [session startRunning];
    
}




- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
     NSLog(@"teh output is %@",output);
    CVImageBufferRef *ImageBufferref= CMSampleBufferGetImageBuffer(sampleBuffer);
}


-(void) requestAuthorizationAccess{
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if(granted){
            
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Granted" message:@"request is allowed" preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"getout" style:UIAlertActionStyleCancel handler:nil];
//            [alert addAction:cancel];
//            
//            [self presentViewController:alert animated:NO completion:nil];
        }
    }];
    
}

@end
