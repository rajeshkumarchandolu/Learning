//
//  ViewController.m
//  imageEditorPOC
//
//  Created by Konymp on 26/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import "ViewController.h"
#import <ImageEditingMarketplaceFramework/CropViewViewController.h>
#import <ImageEditingMarketplaceFramework/ImageEditor.h>

@interface ViewController (){
    UIImage *image;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (IBAction)onClickNaviagteToCropView:(id)sender {
    
    image = [UIImage imageNamed:@"SonyLogo3d"];
    
    
    [ImageEditor LoadCropViewController :image ];
    
}




- (IBAction)onClickStickerView:(id)sender {
    
    
    NSMutableArray<UIImage*> * stickers = [[NSMutableArray alloc] initWithCapacity:10];
    
    for(int i=0;i<10;i++){
        UIImage *stickerImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [stickers addObject:stickerImage];
    }
      image = [UIImage imageNamed:@"SonyLogo3d"];
    [ImageEditor loadStickerViewController:image withStickers:stickers];
    
}




@end
