//
//  CustomView.m
//  ImageEditingMarketplaceFramework
//
//  Created by Konymp on 28/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

typedef enum  {
    Top_left,
    Top_right,
    bottom_left,
    bottom_right,
    Inside,
    outside,
} TouchPositions;


#import "CustomView.h"

@implementation CustomView{
    TouchPositions draggingPosition;
    UIView *croppedView;
}


-(void) setResizableView : (UIView *) resizableView{
    if(resizableView != nil){
        croppedView = resizableView;
    }
}


-(TouchPositions) returnTouchPositionofPoint:(CGPoint) point ofViewBounds:(CGRect) bounds{
    
    float width = bounds.size.width;
    float height = bounds.size.height;
    
    
    //assuming the thumb radius is 10 pixels
    CGFloat thumbRadius =0;
    if((height+width)/10>10){
        thumbRadius = (height+width)/10;
    }else{
        thumbRadius = 10;
    }
    
    
    if(point.x>thumbRadius && point.x<width-thumbRadius && point.y>thumbRadius && point.y < height-thumbRadius){
        return Inside;
    }
    
    //Top_left
    CGPoint TopLeftPoint = CGPointMake(0, 0);
    if( (point.x-TopLeftPoint.x)*(point.x-TopLeftPoint.x) + (point.y-TopLeftPoint.y) * (point.y-TopLeftPoint.y) <= thumbRadius * thumbRadius){
        return Top_left;
    }
    
    //Top_right
    CGPoint TopRightPoint = CGPointMake(width, 0);
    if( (point.x-TopRightPoint.x)*(point.x-TopRightPoint.x) + (point.y-TopRightPoint.y) * (point.y-TopRightPoint.y) <= thumbRadius * thumbRadius){
        return Top_right;
    }
    
    //bottom_left
    CGPoint bottomleftPoint = CGPointMake(0, height);
    if( (point.x-bottomleftPoint.x)*(point.x-bottomleftPoint.x) + (point.y-bottomleftPoint.y) * (point.y-bottomleftPoint.y) <= thumbRadius * thumbRadius){
        return bottom_left;
    }
    
    //bottom_right
    CGPoint bottomRightPoint = CGPointMake(width, height);
    
    if( (point.x-bottomRightPoint.x)*(point.x-bottomRightPoint.x) + (point.y-bottomRightPoint.y) * (point.y-bottomRightPoint.y) <= thumbRadius * thumbRadius){
        return bottom_right;
    }
    
    return outside;
    
}


-(CGPoint) locationInCroppedViewOfPoint :(CGPoint) point  {
    
    CGPoint croppedViewCoOrdinatePoint = CGPointMake(0, 0);
    
    croppedViewCoOrdinatePoint.x = point.x-croppedView.frame.origin.x;
    croppedViewCoOrdinatePoint.y = point.y-croppedView.frame.origin.y;
    return croppedViewCoOrdinatePoint;
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint Initialpositon =[[touches anyObject] locationInView:self];
    Initialpositon = [self locationInCroppedViewOfPoint:Initialpositon];
    TouchPositions touchPosition  = [self returnTouchPositionofPoint:Initialpositon ofViewBounds:croppedView.bounds];
    
    switch (touchPosition) {
        case outside:
            NSLog(@"in the outside dragging position");
            draggingPosition = outside;
            break;
        case Inside:
            NSLog(@"in the inside dragging position");
            draggingPosition = Inside;
            break;
        case Top_right:
            NSLog(@"in the top_right dragging position");
            draggingPosition = Top_right;
            break;
        case Top_left:
            NSLog(@"in the top_left dragging position");
            draggingPosition = Top_left;
            break;
        case bottom_left:
            NSLog(@"in the bottom_left dragging position");
            draggingPosition = bottom_left;
            break;
        case bottom_right:
            NSLog(@"in the bottom-right dragging position");
            draggingPosition = bottom_right;
            break;
        default:
            break;
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Dragging Position : %u",draggingPosition);
    
    CGPoint draggingPoint = [[touches anyObject] locationInView:self];
    CGPoint previouspoint = [[touches anyObject] previousLocationInView:self];
    
    CGFloat updatedheight = draggingPoint.y - previouspoint.y;
    CGFloat updatedWidth = draggingPoint.x - previouspoint.x;
    
    CGFloat height = croppedView.frame.size.height;
    CGFloat width = croppedView.frame.size.width;
    
        NSLog(@"the updatedHeight is :%f and updatedWidth is :%f",updatedheight,updatedWidth);
    CGFloat newOriginX,newOriginY;
    switch (draggingPosition) {
        case Top_right:
            newOriginX= croppedView.frame.origin.x ;
            newOriginY = draggingPoint.y;
            //updating the height
            height = croppedView.frame.size.height + (updatedheight * -1);
            //updating the widhth
            width = croppedView.frame.size.width + updatedWidth;
            
            break;
        case Top_left:
            newOriginX = draggingPoint.x;
            newOriginY = draggingPoint.y;
            height = croppedView.frame.size.height - updatedheight;
            width = croppedView.frame.size.width - updatedWidth;
            break;
        case bottom_left:
            newOriginX = draggingPoint.x;
            newOriginY = draggingPoint.y - croppedView.frame.size.height;
            height = croppedView.frame.size.height + updatedheight;
            width = croppedView.frame.size.width - updatedWidth;
            
            break;
        case bottom_right:
            //no change in origins
            newOriginX = croppedView.frame.origin.x;
            newOriginY = croppedView.frame.origin.y;
            
            height = croppedView.frame.size.height + updatedheight;
            width = croppedView.frame.size.width + updatedWidth;
            
            break;
        default:
            return;
            break;
    }
    if(newOriginY >=0 && newOriginY >=0){
        [croppedView setFrame:CGRectMake(newOriginX, newOriginY, width, height)];
    }
    
    
    NSLog(@"updated origin X: %f Y:%f Width:%f Height:%f",croppedView.frame.origin.x,croppedView.frame.origin.y,croppedView.frame.size.width,croppedView.frame.size.height);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    draggingPosition = outside;
}


@end
