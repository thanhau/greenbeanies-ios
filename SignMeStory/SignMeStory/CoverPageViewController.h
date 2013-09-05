//
//  CoverPageViewController.h
//  SignMeStory
//
//  Created by test on 2/19/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryBookViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CoverPageViewController : UIViewController {
    SignMeStoryFS *storyFS;
    NSString *title;
    bool valid;
    
}

@property (nonatomic) UIImageView * backgroundImageView;
@property (nonatomic) StoryBookViewController *storyBookViewController;

- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle;
- (bool) isAValidBook;

@end
