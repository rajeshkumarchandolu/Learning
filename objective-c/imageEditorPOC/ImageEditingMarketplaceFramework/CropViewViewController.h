//
//  CropViewViewController.h
//  ImageEditingMarketplaceFramework
//
//  Created by Konymp on 26/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CropViewViewController : UIViewController

@property(weak,nonatomic) UIImage * image;

- (void)changeImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
