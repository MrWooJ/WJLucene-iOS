//
//  RestAPI.h
//  WJLibrato
//
//  Created by Alireza Arabi on 9/30/15.
//  Copyright © 2015 Alireza Arabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LuceneAPIManager.h"

@protocol RESTAPIDelegate <NSObject>

- (void)showResult:(NSDictionary *)resultsDictionary;

- (void)showErrorMessage;

@end

@interface RestAPI : NSObject

@property (nonatomic, strong) __block id <RESTAPIDelegate> restAPIDelegate;

+ (RestAPI *)sharedService;

- (void)getResultOfQuery:(NSString *)query;

@end
