//
//  BookPageViewController.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import "BookPageViewController.h"

@interface BookPageViewController ()

@end

@implementation BookPageViewController
@synthesize pageText;
@synthesize backgroundImageView;
@synthesize backgroundImage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //UIImage *img = [UIImage imageNamed:@"storyboardscreen1.png"];
    UIImage *imgChatBubble = [UIImage imageNamed:@"screen1chatbubble.png"];

    // set page background
    self.backgroundImageView = [[UIImageView alloc]init];
    [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    [self.backgroundImageView setImage:self.backgroundImage];
    [self.view addSubview:self.backgroundImageView];
    //NSLog(@"width = %f, height = %f",self.view.bounds.size.height,self.view.bounds.size.width);
    
    
    [self.view setBackgroundColor:[UIColor redColor]];
    self.pageTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [self.pageTextLabel setTextAlignment:NSTextAlignmentCenter];
    [self.pageTextLabel setBackgroundColor: [UIColor redColor]];
    [self.pageTextLabel setTextColor:[UIColor whiteColor]];
    [self.backgroundImageView addSubview:self.pageTextLabel];
    [self.pageTextLabel setText:self.pageText];
    
    // redraw the image to fit |yourView|'s size
    UIGraphicsBeginImageContextWithOptions(self.pageTextLabel.frame.size, NO, 0);
    [imgChatBubble drawInRect:CGRectMake(self.pageTextLabel.bounds.origin.x, self.pageTextLabel.bounds.origin.y+30, self.pageTextLabel.bounds.size.width, self.pageTextLabel.bounds.size.height)]; //hardcoding for location will fix it later
    
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.pageTextLabel setBackgroundColor:[UIColor colorWithPatternImage:resultImage]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
