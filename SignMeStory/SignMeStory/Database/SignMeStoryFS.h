//
//  SignMeStoryFS.h
//  SignMeStory
//
//  Created by YenHsiang Wang on 1/23/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *ImagesDir = @"/Images";
static NSString *InventoryDir = @"/Inventory";
static NSString *DictionaryDir = @"/Dictionary";

@interface SignMeStoryFS : NSObject {
    NSFileManager *filemgr;
    NSMutableString *fsPath;
    NSMutableString *currentPath;
    NSString *currentBookTitle;
}

@property (nonatomic, retain) NSMutableString *fsPath;
@property (nonatomic, retain) NSMutableString *currentPath;
@property (nonatomic, retain) NSString *currentBookTitle;

- (id)initFS;
- (NSMutableArray *) generateBookPaths;
- (UIImage *) getBookShelfBackground;
- (int) getNumberOfPages: (NSString *) bookPath;
- (NSString *) getPageText: (NSString *) pagePath;
- (NSString *) getPageText: (NSString *) bookPath andPageNumber: (int) pageNumber;
- (NSString *) getPageBackground: (NSString *) bookPath andPageNumber: (int) pageNumber;

- (UIImage *) getCoverImg: (NSString *) bookTitle;
- (UIImage *) getReadToMeImg:(NSString *) bookTitle;
- (UIImage *) getReadByMyselfImg: (NSString *) bookTitle;
- (UIImage *) getChatBubbleImg;
- (UIImage *) getLeftButtonImg;
- (UIImage *) getRightButtonImg;
- (UIImage *) getCurlPageImg;
- (UIImage *) getHomeImg;
- (UIImage *) getbookshelfImg:  (NSString *) bookTitle;

- (NSMutableArray *) getPageBackgrounds: (NSString *) pagePath;
- (NSMutableArray *) getListOfText: (NSString *) pagePath;
- (NSMutableArray *) getListOfAudio: (NSString *) pagePath; // database_2012_02_27_JW

@end
