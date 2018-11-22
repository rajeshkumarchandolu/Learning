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
    
    if(point.x<0 || point.x>height|| point.y<0|| point.y>height){
        return outside;
    }
    //each edge can be of width 10 pixels
    
    //searching for the point can exists in topleft
    if(point.x<=10 && point.x>=0 && point.y<=10 && point.y>=0){
        return  Top_left;
    }
    //searching for the point can exists in topright
    if(point.x<=width && point.x>=width-10 && point.y<=10 && point.y>=0){
        return  Top_right;
    }
    //searching for the point can exists in bottomleft
    if(point.x<=10 && point.x>=0 && point.y<=height && point.y>=height-10){
        return  bottom_left;
    }
    //searching for the point can exists in topright
    if(point.x<=width && point.x>=width-10 && point.y<=height && point.y>=height-10){
        return  bottom_right;
    }
    
    return Inside;
    
}


-(CGPoint) locationInCroppedViewOfPoint :(CGPoint) point  {
    
    CGPoint croppedViewCoOrdinatePoint = CGPointMake(0, 0);
    
    croppedViewCoOrdinatePoint.x = point.x-originX;
    croppedViewCoOrdinatePoint.y = point.y-originX;
    
    return croppedViewCoOrdinatePoint;
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for(UITouch *touchpoint in touches){
        Initialpositon =[touchpoint locationInView:self];
        Initialpositon = [self locationInCroppedViewOfPoint:Initialpositon];
        TouchPositions touchPosition  = [self returnTouchPositionofPoint:Initialpositon ofViewBounds:CroppedView.bounds];
        
        switch (touchPosition) {
            case outside:
                draggingPosition = outside;
                break;
            case Inside:
                draggingPosition = Inside;
                break;
            case Top_right:
                NSLog(@"in the top_right dragging position");
                draggingPosition = Top_right;
                break;
            case Top_left:
                draggingPosition = Top_left;
                break;
            case bottom_left:
                draggingPosition = bottom_left;
                break;
            case bottom_right:
                draggingPosition = bottom_right;
                break;
            default:
                break;
        }
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Dragging Position : %u",draggingPosition);
    
    CGPoint draggingPoint = [[touches anyObject] locationInView:self];
    CGPoint previouspoint = [[touches anyObject] previousLocationInView:self];
                             
    CGFloat updatedheight = draggingPoint.y - previouspoint.y;
    CGFloat updatedWidth = draggingPoint.x - previouspoint.x;
    
    NSLog(@"the updatedHeight is :%f and updatedWidth is :%f",updatedheight,updatedWidth);
    CGFloat newOriginX,newOriginY;
    switch (draggingPosition) {
        case Top_right:
            newOriginX= CroppedView.frame.origin.x ;
            newOriginY = draggingPoint.y;
            //updating the height
            height = CroppedView.frame.size.height + (updatedheight * -1);
            //updating the widhth
            width = CroppedView.frame.size.width + updatedWidth;
            [CroppedView setFrame:CGRectMake(newOriginX, newOriginY, width, height)];
            break;
        case Top_left:
            newOriginX = draggingPoint.x;
            newOriginY = draggingPoint.y;
            height = CroppedView.frame.size.height - updatedheight;
            width = CroppedView.frame.size.width - updatedWidth;
            [CroppedView setFrame:CGRectMake(newOriginX, newOriginY, width, height)];
            break;
        case bottom_left:
            newOriginX = draggingPoint.x;
            newOriginY = draggingPoint.y - CroppedView.frame.size.height;
            break;
        case bottom_right:
            break;
        default:
            break;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    draggingPosition = outside;
}


@end
