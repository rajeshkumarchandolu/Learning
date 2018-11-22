//
//  CustomView.m
//  SampleViewDraw
//
//  Created by Konymp on 19/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//



#import "CustomView.h"

typedef enum  {
    Top_left,
    Top_right,
    bottom_left,
    bottom_right,
    Inside,
    outside,
} TouchPositions;


@implementation CustomView{
    UIView *CroppedView;
    TouchPositions draggingPosition;
    CGPoint Initialpositon;
    CGFloat width,height,originX,originY;
    
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self->width = self.bounds.size.width-200;
        self->height = self.bounds.size.height-200;
        originX = 50;
        originY = 50;
        CroppedView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY,width , height)];
        [CroppedView setBackgroundColor:UIColor.magentaColor];
        [CroppedView setHidden:false];
        
        //initialposition
        Initialpositon = CGPointMake(-1, -1);
    }
    return self;
}




// Only override drawRect: if you perform custom drawing.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [UIColor.orangeColor set];
    NSLog(@"in the draw method");
    UIRectFill(CGRectMake(0, 0, 2, self.bounds.size.height));
    [CroppedView setFrame:CGRectMake(originX, originY, width, height)];
  
    [self addSubview:CroppedView];
    
    
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
    
    croppedViewCoOrdinatePoint.x = point.x-CroppedView.frame.origin.x;
    croppedViewCoOrdinatePoint.y = point.y-CroppedView.frame.origin.y;
    return croppedViewCoOrdinatePoint;
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
        Initialpositon =[[touches anyObject] locationInView:self];
        Initialpositon = [self locationInCroppedViewOfPoint:Initialpositon];
        TouchPositions touchPosition  = [self returnTouchPositionofPoint:Initialpositon ofViewBounds:CroppedView.frame];
        
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
    
//    NSLog(@"the updatedHeight is :%f and updatedWidth is :%f",updatedheight,updatedWidth);
    CGFloat newOriginX,newOriginY;
    switch (draggingPosition) {
        case Top_right:
            newOriginX= CroppedView.frame.origin.x ;
            newOriginY = draggingPoint.y;
            //updating the height
            height = CroppedView.frame.size.height + (updatedheight * -1);
            //updating the widhth
            width = CroppedView.frame.size.width + updatedWidth;
           
            break;
        case Top_left:
            newOriginX = draggingPoint.x;
            newOriginY = draggingPoint.y;
            height = CroppedView.frame.size.height - updatedheight;
            width = CroppedView.frame.size.width - updatedWidth;
            break;
        case bottom_left:
            newOriginX = draggingPoint.x;
            newOriginY = draggingPoint.y - CroppedView.frame.size.height;
            height = CroppedView.frame.size.height + updatedheight;
            width = CroppedView.frame.size.width - updatedWidth;
            
            break;
        case bottom_right:
            //no change in origins
            newOriginX = CroppedView.frame.origin.x;
            newOriginY = CroppedView.frame.origin.y;
            
            height = CroppedView.frame.size.height + updatedheight;
            width = CroppedView.frame.size.width + updatedWidth;
            
            break;
        default:
            return;
            break;
    }
    if(newOriginY >0 && newOriginY >0){
      [CroppedView setFrame:CGRectMake(newOriginX, newOriginY, width, height)];
    }
    
    
    NSLog(@"updated origin X: %f Y:%f Width:%f Height:%f",CroppedView.frame.origin.x,CroppedView.frame.origin.y,CroppedView.frame.size.width,CroppedView.frame.size.height);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    draggingPosition = outside;
}


@end
