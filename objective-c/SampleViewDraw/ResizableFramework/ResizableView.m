//
//  ResizableView.m
//  ResizableFramework
//
//  Created by Konymp on 26/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import "ResizableView.h"

@implementation ResizableView

-(void) applyResizingOnView : (UIView *)View withMinCGRect :(CGRect) minRect{
 
   UIView *superview = [View superview];
    
    if(superview == nil){
        //the resizable view is the parent view of the Window or the uiview is not assigned to any view
        NSError *error = [[NSError alloc] initWithDomain:@"Invalid View for the Resizing. The view cannot be Rootkeywindow View and the uiview which is not shown on screen" code:-1 userInfo:nil];
        @throw error;
    }
    
    
    
    
}

@end
