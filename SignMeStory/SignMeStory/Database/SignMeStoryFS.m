//
//  SignMeStoryFS.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 1/23/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import "SignMeStoryFS.h"

@implementation SignMeStoryFS
@synthesize fsPath;
@synthesize currentPath;
@synthesize currentBookTitle;

- (id)initFS
{
    self = [super init];
    if (self) {
        NSMutableString *bundlePath = [NSMutableString stringWithCapacity:4];
        [bundlePath appendString:[[NSBundle mainBundle] bundlePath]];
        fsPath = bundlePath;
        [self setCurrentPath: [[NSMutableString alloc] initWithString:fsPath]];
        //[self generateBookPaths:[NSString stringWithFormat:@"%@%@", fsPath, InventoryDir]];
    }
    return self;
}


// prepare the books in the directory in an array;
- (NSMutableArray *) generateBookPaths {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@%@", fsPath, InventoryDir];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [[NSMutableArray alloc]initWithArray: [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
    }
}

// prepare the bookshelf's image from the file system;
- (UIImage *) getBookShelfBackground {
    NSString *imagePath = [NSMutableString stringWithFormat:@"%@%@", ImagesDir, @"/bookshelf.png"];
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@%@", fsPath, imagePath];
    
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [UIImage imageNamed:imagePath];
    }
}

- (NSString *) getPageText: (NSString *) pagePath {
    if (![self checkForPath:pagePath]) {
        NSLog(@"%@ doesn't exist", pagePath);
        return nil;
    }
    else {
        return[NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/Text.txt", pagePath] encoding:NSUTF8StringEncoding error:nil];
    }
}

- (NSString *) getPageText: (NSString *) bookPath andPageNumber: (int) pageNumber {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/Page_%d", bookPath, pageNumber];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return[NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/Text.txt", path] encoding:NSUTF8StringEncoding error:nil];
    }
}

- (NSString *) getPageBackground: (NSString *) bookPath andPageNumber: (int) pageNumber {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/Page_%d", bookPath, pageNumber];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/Background.png", path] encoding:NSUTF8StringEncoding error:nil];
    }
}

- (int) getNumberOfPages: (NSString *)bookTitle {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@",fsPath, InventoryDir, bookTitle];
    NSMutableArray *temp = [[NSMutableArray alloc]initWithArray: [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
    int nPages = 0;
    for (int i = 0 ; i < [temp count]; i ++) {
        if ([[temp objectAtIndex:i] integerValue] > 0)
            nPages++;
    }
    
    return nPages;
}


- (UIImage *) getCoverImg: (NSString *) bookTitle {
    
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/coverPage.jpg",fsPath, InventoryDir, bookTitle];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIImage *) getReadToMeImg: (NSString *) bookTitle {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/readToMe.png",fsPath, InventoryDir, bookTitle];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIImage *) getReadByMyselfImg: (NSString *) bookTitle {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/withoutaudioicon.png",fsPath, InventoryDir, bookTitle];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}


- (UIImage *) getChatBubbleImg {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/chatBubble.png",fsPath, InventoryDir, [self currentBookTitle]];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return [UIImage imageNamed:@"Default.png"];
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIImage *) getLeftButtonImg {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/greenarrowLeft.png",fsPath, InventoryDir, [self currentBookTitle]];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return [UIImage imageNamed:@"Default.png"];
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIImage *) getRightButtonImg {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/greenarrowRight.png",fsPath, InventoryDir, [self currentBookTitle]];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return [UIImage imageNamed:@"Default.png"];
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (NSMutableArray *) getPageBackgrounds: (NSString *) pagePath {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@%@%@/Backgrounds",fsPath, InventoryDir, pagePath];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        NSMutableArray *backgroundArray = [[NSMutableArray alloc]initWithArray: [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
        NSMutableArray *imgArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [backgroundArray count]; i++) {
            UIImage *tempImg = [UIImage imageWithContentsOfFile: [NSString stringWithFormat:@"%@/%@", path, [backgroundArray objectAtIndex:i]]];
            [imgArray addObject: tempImg];
        }
        
        if ([imgArray count] == 0) {
            UIImage *tempImg = [UIImage imageNamed:@"Default.png"];
            [imgArray addObject:tempImg];
        }
        return imgArray;
    }
}


- (NSMutableArray *) getListOfText: (NSString *) pagePath {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@%@%@/Text",fsPath, InventoryDir, pagePath];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        NSMutableArray *textFiledArray = [[NSMutableArray alloc]initWithArray: [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
        NSMutableArray *textArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [textFiledArray count]; i++) {
            NSString *tempStr = [NSString stringWithContentsOfFile: [NSMutableString stringWithFormat:@"%@/%@", path, [textFiledArray objectAtIndex:i]] encoding:NSASCIIStringEncoding error:nil];
            [textArray addObject: tempStr];
        }
        
        if ([textArray count] == 0) {
            [textArray addObject:@"..."];
        }
        return textArray;
    }
}

- (bool) checkForPath: (NSString *) path {
    // the following part is for debugging
    /*
    NSArray *contents  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    int numberOfFiles = [contents count];
    NSLog(@"current Path :%@, %d files", path, numberOfFiles);
    
    for (int i = 0; i < numberOfFiles; i++)
        NSLog (@"%@", [contents objectAtIndex: i]);
    */
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

- (void) deleteFileDirectory: (NSString *) path {
    [filemgr removeItemAtPath: path error: nil];
}

@end
