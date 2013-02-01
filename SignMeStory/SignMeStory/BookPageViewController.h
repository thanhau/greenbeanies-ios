//
//  BookPageViewController.h
//  SignMeStory
//
//  Created by YenHsiang Wang on 12/6/12.
//  Copyright (c) 2012 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BookPageViewController : UIViewController<AVAudioPlayerDelegate>
@property (nonatomic) UILabel *pageTextLabel;
@property (nonatomic) UIImageView * backgroundImageView;
@property (nonatomic) UIImage *backgroundImage;
@property (nonatomic) UITextView *textView;
@property (nonatomic) UIWebView *webView;
@property (nonatomic, strong) NSMutableArray *animationImage;
@property (nonatomic, strong) NSString *pageText;
@property (nonatomic, strong) UITapGestureRecognizer *singeTap;
@property (strong, nonatomic) UIToolbar *toolBar;



@end
