//
//  ListOfBookVocabularyViewController.h
//  SignMeStory
//
//  Created by Thanh Au on 10/3/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignMeStoryFS.h"
#import "VocabularyViewController.h"
@interface ListOfBookVocabularyViewController : UITableViewController
{
    SignMeStoryFS *storyFS;
    NSString *title;
}
@property (nonatomic, strong) NSMutableArray *listOfBook;
- (id) initWithStoryBooksFS: (SignMeStoryFS *) aStoryFS andTitle:(NSString *) aBookTitle;
@end
