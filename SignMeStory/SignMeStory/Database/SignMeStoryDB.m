//
//  SignMeStoryDB.m
//  SignMeStory
//
//  Created by YenHsiang Wang on 1/13/13.
//  Copyright (c) 2013 YenHsiang Wang. All rights reserved.
//

#import "SignMeStoryDB.h"

@interface SignMeStoryDB (private)
-(void) createInventoryTable;
-(void) createSignDictionaryTable;
-(void) createBookTable; // If we decide to create a table for each individual book this method should will create a table whose name is going to be the book's name
-(void) showErrMsg: (NSString *) msg;

//debugging methods
-(void) forTesting;
-(void) dropTable:(NSString *) tableName;
-(void) display;
-(void) insertDefaultRecords;

@end

@implementation SignMeStoryDB
/*
 *  Initialize the Database. Create a new one if it does not exsit,
 *  otherwise open the existing one.
 */
-(id) initDB {
    NSLog(@"Initializing Database");
    
    if (self = [super init]) {
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = [path objectAtIndex:0];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"SignMeStory.sqlite"];
        
        const char *dbPathString = [dbPath UTF8String];
        
        //create db
        if (sqlite3_open(dbPathString, &storyDB) == SQLITE_OK) {
            NSLog(@"Ledger DB opened");
        } else {
            NSLog(@"Error: failed to CREATE/OPEN database due to %s.", sqlite3_errmsg(storyDB));
        }
        
        char *error;
        //enable forign key constrain
        NSString *enable_FK = [NSString stringWithFormat:@"PRAGMA foreign_keys = ON"];
        if (sqlite3_exec(storyDB, [enable_FK UTF8String], NULL, NULL, &error) != SQLITE_OK) {
            NSLog(@"Error: failed to ENABLE Forign Key due to %s", sqlite3_errmsg(storyDB));
        }
        
        //create tables here
        [self createInventoryTable];
        [self createSignDictionaryTable];
        [self createBookTable];
        
        [self forTesting];
    }
    return self;
}

// for testing
-(void) forTesting {
    //drop tables
    //[self insertDefaultRecords];
    //[self display];
}

//Create Tables
-(void) createInventoryTable {
    char *error;
    const char *sql_stmt =
    "CREATE TABLE IF NOT EXISTS INVENTORY (                 "
    "   BOOK_ID         INTEGER PRIMARY KEY AUTOINCREMENT,  "
    "   BOOK_NAME       TEXT NOT NULL,                      "
    "   AUTHOR_LAST     TEXT,                               "
    "   AUTHOR_FIRST    TEXT,                               "
    "   PUBLISH_DATE    TEXT,                               "
    "   PURCHASE_DATE   TEXT,                               "
    "   DIFFICULTY      INTEGER,                            "
    "   TOTAL_PAGE      INTEGER                             "
    ")";
    if (sqlite3_exec(storyDB, sql_stmt, NULL, NULL, &error) != SQLITE_OK) {
        [self showErrMsg: @"CREATE INEVENTORY TABLE"];
    }
}

-(void) createSignDictionaryTable {
    char *error;
    const char *sql_stmt =
    "CREATE TABLE IF NOT EXISTS SIGNDICTIONARY ("
    "   VOCABULARY  TEXT NOT NULL PRIMARY KEY,  "
    "   VIDEO       TEXT,                       " // save the video file as a string of file path.
    "   AUDIO       TEXT                        " // save the audio file as a string of file path.
    ");";
    if (sqlite3_exec(storyDB, sql_stmt, NULL, NULL, &error) != SQLITE_OK) {
        [self showErrMsg: @"CREATE SIGNDICTIONARY TABLE"];
    }
}

-(void) createBookTable {
    char *error;
    const char *sql_stmt =
    "CREATE TABLE IF NOT EXISTS BOOK (      "
    "   BOOK_ID     INTEGER PRIMARY KEY,    "
    "   PAGE_N      INTEGER NOT NULL,       "
    "   VOCABULARY_LIST  TEXT,              " // save the vobaculary list as a string of file path.
    "   TEXT        TEXT,                   " // save the text as a string of file path.
    "   AUDIO       TEXT,                   " // save the audio as a string of file path.
    "   ANIMATION   TEXT,                   " // save the animation as a string of file path.
    "   BACKGROUND  TEXT,                   " // save the background as a string of file path.
    "   FOREIGN KEY (BOOK_ID) REFERENCES INVENTORY(BOOK_ID),"
    ");";
    if (sqlite3_exec(storyDB, sql_stmt, NULL, NULL, &error) != SQLITE_OK) {
        [self showErrMsg: @"CREATE BOOK TABLE"];
    }
    // create unique index so no duplicated page number in a book.
    const char *index_stmt =
    "CREATE UNIQUE INDEX IF NOT EXISTS Book_page ON BOOK (BOOK_ID, PAGE_N);";
    if (sqlite3_exec(storyDB, index_stmt, NULL, NULL, &error) != SQLITE_OK) {
        [self showErrMsg: @"CREATE INDEX on TRANSACTIONS"];
    }
}

//Insert Tables
//these method's parameter may increase as we decide which is necessary or we can just use update to change the column's value.
-(void) insertInventoryTable:(NSString *) bookName {
    char *error;
    NSString *insert_stmt =
    [NSString stringWithFormat:@"INSERT INTO INVENTORY(BOOK_NAME) VALUES ('%@')", bookName];
    
    if (sqlite3_exec(storyDB, [insert_stmt UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        [self showErrMsg: [NSString stringWithFormat:@"INSERT %@ INTO INVENTORY TABLE", bookName]];
    }
}

-(void) insertSignDictionaryTable:(NSString *) vocabulary {
    char *error;
    NSString *insert_stmt =
    [NSString stringWithFormat:@"INSERT INTO SIGNDICTIONARY(VOCABULARY) VALUES ('%@')", vocabulary];
    
    if (sqlite3_exec(storyDB, [insert_stmt UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        [self showErrMsg: [NSString stringWithFormat:@"INSERT %@ INTO SIGNDICTIONARY TABLE", vocabulary]];
    }
}

-(void) insertBookTable:(NSString *) bookID {
    char *error;
    NSString *insert_stmt =
    [NSString stringWithFormat:@"INSERT INTO BOOK(BOOK_ID) VALUES ('%d')", [bookID intValue]];
    
    if (sqlite3_exec(storyDB, [insert_stmt UTF8String], NULL, NULL, &error) != SQLITE_OK) {
        [self showErrMsg: [NSString stringWithFormat:@"INSERT %@ INTO BOOK TABLE", bookID]];
    }
}

//for debugging
-(void) display {
    sqlite3_stmt *select = nil;
    NSString *select_stmt = [NSString stringWithFormat:@"SELECT * FROM INVENTORY"];
}

// show error message from the database. 
-(void) showErrMsg: (NSString *) msg{
    NSLog(@"Error: failed to %@ due to %s", msg, sqlite3_errmsg(storyDB));
}

//Close database
-(void) closeDB {
    sqlite3_close(storyDB);
}

@end





