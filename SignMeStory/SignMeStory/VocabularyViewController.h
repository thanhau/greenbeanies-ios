//
//  VocabularyViewController.h
//  SignMeStory
//
//  Created by Thanh Au on 10/4/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface VocabularyViewController : UITableViewController
{
    NSMutableArray *listOfVocabulary;
    MPMoviePlayerController *mpc;
}
- (void) initWithData: (NSString *) data;
@end
