//
//  SignMeStoryDB.h
//  SignMeStory
//
//  Created by YenHsiang Wang on 1/13/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SignMeStoryDB : NSObject {
    sqlite3 *storyDB;
}
// initiate Database
-(id) initDB;

// insert tables
-(void) insertInventoryTable:(NSString *) bookName;
-(void) insertSignDictionaryTable:(NSString *) vocabulary;
-(void) insertBookTable:(NSString *) bookID;

// update tables

// delete tables
-(void) deleteInventory:(NSString *) bookID; // or book name
-(void) deleteSignDctionary:(NSString *) vocabulary;
-(void) deleteBook:(NSString *) bookID;

// clise database
-(void) closeDB;

@end
