//
//  CropViewViewController.m
//  ImageEditingMarketplaceFramework
//
//  Created by Konymp on 26/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import "CropViewViewController.h"
#import "CustomView.h"


@interface CropViewViewController (){
    UIImage *loadImage;
    UIView *resizableview;
}
    


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet CustomView *CroppingArea;

@end

@implementation CropViewViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGFloat defaultHeightOfResizableView = 100, defaultWidthOfResizableView = 100;
    
    //find center of the _croppingArea
    CGFloat ResizableViewOriginy = (_CroppingArea.frame.size.height/2)- (defaultHeightOfResizableView/2);
    CGFloat ResizableViewOriginX = (_CroppingArea.frame.size.width/2)- (defaultWidthOfResizableView/2);
    
    
    resizableview = [[UIView alloc] initWithFrame:CGRectMake(ResizableViewOriginX, ResizableViewOriginy, defaultWidthOfResizableView, defaultHeightOfResizableView)];
    
    [resizableview setBackgroundColor:[UIColor colorWithDisplayP3Red:0.5 green:0 blue:0.5 alpha:0.5]];
    
    [_CroppingArea addSubview:resizableview];
    
    [_CroppingArea setResizableView:resizableview];

}

- (void)changeImage:(UIImage *)image{
    NSLog(@"in the set image");
    self->loadImage = image;
    _imageView.image = image;
}


- (IBAction)onCLickCrop:(id)sender {
    
    //Dimensions of the imageView
     CGSize imageContainerSize = _imageView.frame.size;
    //Dimensions of the imageContainer
    CGSize imageSize = loadImage.size;
    
    CGFloat scaleX = imageSize.width/imageContainerSize.width;
    CGFloat scaleY = imageSize.height/imageContainerSize.height;
    
    CGRect newRect = resizableview.frame;
    
    UIGraphicsBeginImageContext(CGSizeMake(newRect.size.width*scaleX, newRect.size.height*scaleY));

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToRect(context, CGRectMake(0, 0, (newRect.size.width*scaleX), (newRect.size.height*scaleY)));
//    [loadImage drawInRect:CGRectMake((newRect.origin.x*-1.0),(newRect.origin.y * -1.0), newRect.size.width, newRect.size.height)];
    
    [loadImage drawAtPoint:CGPointMake(((newRect.origin.x*scaleX)*-1.0),((newRect.origin.y*scaleY) * -1.0))];
    
     loadImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
    _imageView.image = loadImage;
    
   
    
  CGImageRef croppedImage = CGImageCreateWithImageInRect([_imageView.image CGImage], CGRectMake(0, 0, 100, 500));
//    CGFloat scale = _imageView.frame.size.width/resizableview.frame.size.width;
//
//   _imageView.image =  [UIImage imageWithCGImage: croppedImage scale:scale orientation:UIImageOrientationUp];
//
//    CGImageRelease(croppedImage);
}



-(void) saveimagetoGallery{
    UIImageWriteToSavedPhotosAlbum(loadImage, self,  @selector(sucess:didFinishSavingWithError:contextInfo:), nil);
    
}
- (IBAction)onClickSaveImage:(id)sender {
    [self saveimagetoGallery];
}


- (void)sucess:(UIImage *)image
didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    NSLog(@"in the sucess or failure callback of the save images");
}






@end
