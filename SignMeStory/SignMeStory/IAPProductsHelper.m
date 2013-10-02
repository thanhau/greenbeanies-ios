//
//  IAPProductsHelper
//	Sign Me A Story
//
//  Created by Johnny on 9/5/12.
//  Copyright (c) 2013 High Development Mobile Applications, Inc. All rights reserved.
//

#import "IAPProductsHelper.h"

@implementation IAPProductsHelper

+ (IAPProductsHelper *)sharedInstance {
    static dispatch_once_t once;
    static IAPProductsHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.Signmeastory.greeniebeanies.2",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
