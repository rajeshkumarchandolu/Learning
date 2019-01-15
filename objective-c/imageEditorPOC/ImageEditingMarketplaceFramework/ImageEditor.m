//
//  ImageEditor.m
//  ImageEditingMarketplaceFramework
//
//  Created by Konymp on 26/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import "ImageEditor.h"
#import "CropViewViewController.h"
#import "StickerViewController.h"

#import <UIKit/UIKit.h>

@implementation ImageEditor


+(void) LoadCropViewController :(UIImage *) image{
    
    UIStoryboard *cropStoryBoard = [UIStoryboard storyboardWithName:@"CropImageStoryBoard" bundle:[NSBundle bundleForClass:[CropViewViewController class]]];
    CropViewViewController *croppedController = [cropStoryBoard instantiateInitialViewController];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:croppedController animated:NO completion:nil] ;
    
    [croppedController changeImage:image];

    
}



+(void) loadStickerViewController :(UIImage *)image withStickers :(NSArray<UIImage*>*) stickerImages {
    
    UIStoryboard *cropStoryBoard = [UIStoryboard storyboardWithName:@"CropImageStoryBoard" bundle:[NSBundle bundleForClass:[CropViewViewController class]]];
    StickerViewController *stickerController = [cropStoryBoard instantiateInitialViewController];
    stickerController.editableImage = image;

       [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:stickerController animated:NO completion:nil] ;
    
    stickerController.stickerImages = stickerImages;
    }


+(void)cropView{
    
    
    
}

@end
