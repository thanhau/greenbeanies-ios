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
@synthesize textView;
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
    UIImageView *textBackground = [[UIImageView alloc]initWithImage:imgChatBubble];
    

    // set page background
    self.backgroundImageView = [[UIImageView alloc]init];
    [self.backgroundImageView setFrame: CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    [self.backgroundImageView setImage:self.backgroundImage];
    [self.view addSubview:self.backgroundImageView];
    
    textBackground.frame = CGRectMake(self.view.frame.origin.x + 20, self.view.frame.origin.y + 10, 400, 400);
        
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(textBackground.frame.origin.x, textBackground.frame.origin.y, textBackground.frame.size.width, textBackground.frame.size.height)];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setTextColor:[UIColor whiteColor]];
    [self.textView setText:self.pageText];
    [self.backgroundImageView addSubview:textBackground];
    
    [textBackground addSubview:self.textView];

    /*
    [self.view setBackgroundColor:[UIColor redColor]];
    self.pageTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [self.pageTextLabel setTextAlignment:NSTextAlignmentLeft];
    [self.pageTextLabel setBackgroundColor: [UIColor redColor]];
    [self.pageTextLabel setTextColor:[UIColor whiteColor]];
    [self.backgroundImageView addSubview:self.pageTextLabel];
    [self.pageTextLabel setText:self.pageText];
     */
    
    CGRect frame = self.textView.frame;
    frame.size.height = self.textView.contentSize.height;
    self.textView.frame = frame;
    
    
    /*
    // redraw the image to fit |yourView|'s size
    UIGraphicsBeginImageContextWithOptions(self.textView.frame.size, NO, 0);
    [imgChatBubble drawInRect:CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.frame.size.width, self.textView.frame.size.height)]; //hardcoding for location will fix it later
    
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.textView setBackgroundColor:[UIColor colorWithPatternImage:resultImage]];
     */

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
