//
//  StickerViewController.m
//  ImageEditingMarketplaceFramework
//
//  Created by Konymp on 06/12/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#import "StickerViewController.h"

@implementation StickerViewController{
    
    __weak IBOutlet UIView *StickerView;
    __weak IBOutlet UIImageView *ImageView;
    IBOutlet UIView *superView;
    __weak IBOutlet UITableView *StickerTableView;
   
    __weak IBOutlet UIView *imageEditorView;
    
    __weak IBOutlet UIView *stickerView;
    
    NSMutableArray<UIImageView*> *stickerImageviews;
    
}
- (void)viewDidLoad{
    StickerTableView.dataSource = self;
    StickerTableView.delegate = self;
    ImageView.image= _editableImage;
    stickerImageviews = [[NSMutableArray alloc] initWithCapacity:10];
}


-(void) panGestureperformedOnSticker  :(UIPanGestureRecognizer *) recognizer{
    UIView *sticker = recognizer.view;
    CGPoint newpoint = [recognizer locationInView:imageEditorView];
    [sticker setCenter:newpoint];
}

-(void) pinchGesturePerformedOnSticker: (UIPinchGestureRecognizer *) recognizer{
    UIView *sticker = recognizer.view;
    CGFloat scale = recognizer.scale;
    NSLog(@"pinchGestureRecognized with scale :%f",scale);
    [sticker setTransform:CGAffineTransformMakeScale(scale,scale)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}
- (IBAction)onclickReset:(id)sender {
    [stickerView setHidden:false];
}
- (IBAction)onClickSavebutton:(id)sender {
   
    UIGraphicsBeginImageContext(imageEditorView.frame.size);
    [imageEditorView drawViewHierarchyInRect:[imageEditorView bounds] afterScreenUpdates:true];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reusableIdentifier1"];
    NSInteger row =[indexPath row];
    UIImage *currentImage = [_stickerImages objectAtIndex:row];
    UIImageView *imageContainer = [[UIImageView alloc] initWithImage:currentImage];
    [imageContainer setFrame:CGRectMake(10, 10, 100, 100)];
    [[cell contentView] addSubview:imageContainer];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected the row %ld",(long)[indexPath row]);
    [stickerView setHidden:true];
    //selected Sticker
    UIImage *selectedSticker = [_stickerImages objectAtIndex:[indexPath row]];
    //create a imageView
    UIImageView *newStickerImageView = [[UIImageView alloc] initWithImage:selectedSticker];
    [newStickerImageView setFrame:CGRectMake(0, 0, 100, 100)];
    //additon of the new sticker to the uiview
    [imageEditorView addSubview:newStickerImageView];
    //addition the pinch and pan gesture
    [newStickerImageView setUserInteractionEnabled:true];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureperformedOnSticker:)];
    [newStickerImageView addGestureRecognizer:panGesture];
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesturePerformedOnSticker:)];
    [newStickerImageView addGestureRecognizer:pinchGesture];
}

@end
