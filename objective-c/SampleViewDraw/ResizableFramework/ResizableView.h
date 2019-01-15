//
//  ResizableView.h
//  ResizableFramework
//
//  Created by Konymp on 26/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResizableView : NSObject

-(void) applyResizingOnView : (UIView *)View withMinCGRect :(CGRect) minRect;

@end

NS_ASSUME_NONNULL_END
