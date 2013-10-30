//
//  VocabularyViewController.h
//  SignMeStory
//
//  Created by Thanh Au on 10/4/13.
//  Copyright (c) 2013 Thanh Au. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface VocabularyViewController : UITableViewController
{
    NSMutableArray *listOfVocabulary;
    MPMoviePlayerController *mpc;
    NSString* bookTitle;
}
- (void) initWithData: (NSString *) data bookTitle:(NSString*) title;
@end
