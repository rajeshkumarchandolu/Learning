//
//  CustomView.m
//  SampleViewDraw
//
//  Created by Konymp on 19/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView


-(instancetype) initWith:(CGRect) frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [UIColor.orangeColor set];

    NSLog(@"in the draw method");
    UIRectFill(CGRectMake(0, 0, 2, self.bounds.size.height));


}

@end
