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
        bundlePath = nil;
        /*
        NSMutableString *path1 = [NSMutableString stringWithFormat:@"%@/Inventory/Greenbeanies/",fsPath];
        NSMutableString *path2 = [NSMutableString stringWithFormat:@"%@/Inventory/Greenbeanies2/",fsPath];
        if ([self checkForPath:path1]) {
            NSLog(@"Path need to delete");
            [self deleteFileDirectory:path1];
        }
        if ([self checkForPath:path2]) {
            NSLog(@"Path need to delete");
            [self deleteFileDirectory:path2];
        }
        */
    }
    
    return self;
}


// prepare the books in the directory in an array;
- (NSMutableArray *) generateBookPaths {
    
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@%@", fsPath, InventoryDir];
    NSMutableArray *temp = [[NSMutableArray alloc]initWithArray: [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
    NSMutableArray *listOfBook = [[NSMutableArray alloc] initWithCapacity:[temp count]];
    NSLog(@"%@",temp);
    for (int i = 0; i < [temp count]; i++) {
        NSString *s = temp[i];
        if (isnumber([s characterAtIndex:0])) {
            [listOfBook addObject:temp[i]];
        }
    }
    
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        path = nil;
        return nil;
    }
    else {
        //return [[NSMutableArray alloc]initWithArray: [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
        return listOfBook;
    }
}


// prepare the bookshelf's image from the file system;
- (UIImage *) getBookShelfBackground {
    //NSString *imagePath = [NSMutableString stringWithFormat:@"%@%@", ImagesDir, @"/bookshelf.png"];
    NSString *imagePath = [NSMutableString stringWithFormat:@"%@%@", ImagesDir, @"/Bookshelf.jpg"];
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@%@", fsPath, imagePath];
    
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        path = nil;
        return nil;
    }
    else {
        return [UIImage imageNamed:imagePath];
    }
}
- (NSMutableArray *) getListOfVocabulary:(NSString *) bookTitle
{
    NSMutableArray *listOfVocabulary = [[NSMutableArray alloc] init];
    
    int numberOfBook = [bookTitle integerValue];
    for (int i = 0; i < numberOfBook; i++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        NSString *bookTitleString = [NSString stringWithFormat:@"Greenbeanies%i.txt",i+1];
        NSString *temp;
        switch (i + 1) {
            case 1:
            	temp = @"GreenBeanies - One Cool Cat";
            	break;
        	case 2:
            	temp = @"GreenBeanies - Two Magical Cats";
            	break;
            default:
            	temp = @"Greenbeanies";
            	break;
        }

        NSString *key = temp;
        temp = nil;
        NSString *vocabularyPath = [NSMutableString stringWithFormat:@"%@/%@",Vocabulary,bookTitleString];
        NSMutableString *path = [NSMutableString stringWithFormat:@"%@%@",fsPath,vocabularyPath];
        //NSLog(@"%@",path);
        if ([self checkForPath:path]) {
            NSError *error;
            NSString *content = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            NSLog(@"%@",content);
            path = nil;
            vocabularyPath = nil;
            [tempDict setObject:content forKey:key];
            
            [listOfVocabulary addObject:tempDict];
        }
        bookTitleString = nil;
        key = nil;
    }
    return listOfVocabulary;
   
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
    path = nil;
    temp = nil;
    return nPages;
}


- (UIImage *) getCoverIcon: (NSString *) bookTitle {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/coverPage.jpg",fsPath, InventoryDir, bookTitle];
    NSLog(@"path = %@", path);
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIImage *) getCoverImg: (NSString *) bookTitle {
    
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/coverPage.jpg",fsPath, InventoryDir, bookTitle];
    NSLog(@"path = %@", path);
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}
- (UIImage *) getDemoImg: (NSString *) bookTitle {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/Demoicon.png",fsPath, InventoryDir, bookTitle];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIImage *) getReadToMeImg: (NSString *) bookTitle {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/readwithaudio.png",fsPath, InventoryDir, bookTitle];
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
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/leftarrow.png",fsPath, InventoryDir, [self currentBookTitle]];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return [UIImage imageNamed:@"Default.png"];
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIImage *) getRightButtonImg {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/rightarrow.png",fsPath, InventoryDir, [self currentBookTitle]];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return [UIImage imageNamed:@"Default.png"];
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}
- (UIImage *)getbookshelfImg:  (NSString *) bookTitle  {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/bookshelficon.png",fsPath, InventoryDir, bookTitle];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIImage *)getCoverIconForBook:  (NSString *) bookTitle  {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/coverPage.jpg",fsPath, InventoryDir, bookTitle];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIImage *) getCurlPageImg {
    NSString *path = [NSString stringWithFormat:@"%@/%@/PageCurl.png",fsPath, ImagesDir];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return [UIImage imageNamed:@"Default.png"];
    }
    else {
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIImage *)getHomeImg {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Other/home.png",fsPath, InventoryDir, [self currentBookTitle]];
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
        
        NSArray *sortedBackgroundFileArray = [backgroundArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        
        for (int i = 0; i < [backgroundArray count]; i++) {
            UIImage *tempImg = [UIImage imageWithContentsOfFile: [NSString stringWithFormat:@"%@/%@", path, [sortedBackgroundFileArray objectAtIndex:i]]];
            [imgArray addObject: tempImg];
            tempImg = nil;
        }
        
        if ([imgArray count] == 0) {
            UIImage *tempImg = [UIImage imageNamed:@"Default.png"];
            [imgArray addObject:tempImg];
            tempImg = nil;
        }
        path = nil;
        backgroundArray = nil;
        sortedBackgroundFileArray =nil;
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
        
        NSArray *sortedTextFileArray = [textFiledArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        
        for (int i = 0; i < [textFiledArray count]; i++) {
            NSString *tempStr = [NSString stringWithContentsOfFile: [NSMutableString stringWithFormat:@"%@/%@", path, [sortedTextFileArray objectAtIndex:i]] encoding:NSASCIIStringEncoding error:nil];
            [textArray addObject: tempStr];
            tempStr = nil;
        }
        
        if ([textArray count] == 0) {
            [textArray addObject:@""];
        }
        path = nil;
        textFiledArray = nil;
        sortedTextFileArray = nil;
        return textArray;
    }
}

- (NSMutableArray *) getListOfZoomSpec: (NSString *) pagePath {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@%@%@/ZoomSpec",fsPath, InventoryDir, pagePath];
    
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        NSMutableArray *zoomSpecFiledArray = [[NSMutableArray alloc]initWithArray: [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
        //NSLog(@"count = %i",[zoomSpecFiledArray count]);
        if ([zoomSpecFiledArray count] != 0) {
            NSMutableArray *zoomSpecArray = [[NSMutableArray alloc] init];
            NSArray *sortedZoomSpecFileArray = [zoomSpecFiledArray sortedArrayUsingComparator: ^(id obj1, id obj2){
                return  [obj1 compare:obj2 options:NSNumericSearch];
            }];
            
            for (int i = 0; i < [zoomSpecFiledArray count]; i++) {
                NSString *tempStr = [NSString stringWithContentsOfFile:[NSMutableString stringWithFormat:@"%@/%@",path, [sortedZoomSpecFileArray objectAtIndex:i]] encoding:NSASCIIStringEncoding error:nil];
                //NSLog(@"%@",tempStr);
                [zoomSpecArray addObject:tempStr];
                tempStr = nil;
            }
            //NSLog(@"%@",zoomSpecArray);
            if ([zoomSpecArray count] == 0) {
                [zoomSpecArray addObject:@""];
            }
            path = nil;
            zoomSpecFiledArray = nil;
            sortedZoomSpecFileArray = nil;
            return zoomSpecArray;
        }
        
        
        return nil;
        
        
    }
}
// database_2012_02_27_JW
- (NSMutableArray *) getListOfAudio: (NSString *) pagePath{
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@/%@/Audio",fsPath, InventoryDir, pagePath];
    if (![self checkForPath:path]) {
        NSLog(@"%@ doesn't exist", path);
        return nil;
    }
    else {
        NSMutableArray *audioFileArray = [[NSMutableArray alloc]initWithArray: [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
        NSMutableArray *audioArray = [[NSMutableArray alloc] init];
        
        if ([audioFileArray count ] == 0) {
            return nil;
        }
        else {
            NSArray *sortedAudioFileArray = [audioFileArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                return [obj1 compare:obj2 options:NSNumericSearch];
            }];
            for (int i = 0; i < [audioFileArray count]; i++) {
                NSURL *urlAudio = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", path, [sortedAudioFileArray objectAtIndex:i]]];
                [audioArray addObject: urlAudio];
                urlAudio = nil;
            }
            path = nil;
            audioFileArray = nil;
            sortedAudioFileArray = nil;
            
        }
        return audioArray;
    }
}

- (bool) checkForPath: (NSString *) path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

- (void) deleteFileDirectory: (NSString *) path {
    //[filemgr removeItemAtPath: path error: nil];
    NSError *error;
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:path]) {
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        if (!success) {
            NSLog(@"Error removing file at path: %@", error.localizedDescription);
        }
    }
    else
    {
        NSLog(@"Can not delete");
    }
    
    
}

@end
