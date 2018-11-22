//
//  ViewController.m
//  SampleViewDraw
//
//  Created by Konymp on 19/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController{
    CustomView *cropView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    cropView = [[CustomView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    cropView.backgroundColor = UIColor.greenColor;
    [[self view] addSubview:cropView];
    cropView.userInteractionEnabled = true;
    UIRotationGestureRecognizer *rotationalRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(onRotationPerformed:)];
    [cropView addGestureRecognizer:rotationalRecognizer];
    
    
    
    
    
    
 
}

-(void) onRotationPerformed:(UIRotationGestureRecognizer *) sender {
    cropView.transform = CGAffineTransformRotate(cropView.transform, sender.rotation);
    NSLog(@"sender rotation is :%f",sender.rotation);
    sender.rotation = 0.0;
}


@end
