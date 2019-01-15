//
//  StickerViewController.h
//  ImageEditingMarketplaceFramework
//
//  Created by Konymp on 06/12/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StickerViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>


@property(strong,nonatomic) NSArray<UIImage*> *stickerImages;
@property(strong,nonatomic) UIImage *editableImage;


@end

NS_ASSUME_NONNULL_END
