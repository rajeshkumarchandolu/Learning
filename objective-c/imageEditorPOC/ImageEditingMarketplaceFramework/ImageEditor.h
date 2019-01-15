//
//  ImageEditor.h
//  ImageEditingMarketplaceFramework
//
//  Created by Konymp on 26/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageEditor : NSObject

+(void) LoadCropViewController :(UIImage *) image ;

+(void) loadStickerViewController :(UIImage *)image withStickers : (NSArray<UIImage*>*) stickerImages;

+(void) cropView;

@end

NS_ASSUME_NONNULL_END
