//
//  QueryProducer.m
//  Lucene-iOS
//
//  Created by Alireza Arabi on 11/3/15.
//  Copyright © 2015 Alireza Arabi. All rights reserved.
//

#import "UtilityHelper.h"

static NSString* CORE_NEWSURL				= @"core_news_url";
static NSString* CORE_NEWSNUMBER 			= @"core_news_number";
static NSString* CORE_NEWSTITLE 			= @"core_new_title";
static NSString* CORE_NEWSBODY				= @"core_news_body";
static NSString* CORE_NEWSDATE				= @"core_news_date";
static NSString* CORE_NEWSSOURCE 			= @"core_news_source";
static NSString* COMMENT_ID 				= @"comment_id";
static NSString* COMMENT_PARENTID			= @"comment_parentId";
static NSString* COMMENT_COMMENTER			= @"comment_commenter";
static NSString* COMMENT_LOCATION			= @"comment_location";
static NSString* COMMENT_DATE				= @"comment_date";
static NSString* COMMENT_LIKECOMMENT 		= @"comment_like_comment";
static NSString* COMMENT_DISLIKECOMMENT		= @"comment_dislike_comment";
static NSString* COMMENT_RESPONSECOUNT		= @"comment_response_count";
static NSString* COMMENT_BODY				= @"comment_body";
static NSString* CATEGORY_NEWS				= @"core_category";
static NSString* LABEL_NEWS 				= @"core_label";
static NSString* OPERATOR					= @"operator";

@implementation UtilityHelper

+ (NSString *)produceQuery {
	
	NSUserDefaults *dictionary = [NSUserDefaults standardUserDefaults];
	NSString *queryString = @"";
	
	if ([dictionary valueForKey:CORE_NEWSURL])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",CORE_NEWSURL,[dictionary valueForKey:CORE_NEWSURL]];
	if ([dictionary valueForKey:CORE_NEWSNUMBER])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",CORE_NEWSNUMBER,[dictionary valueForKey:CORE_NEWSNUMBER]];
	if ([dictionary valueForKey:CORE_NEWSTITLE])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",CORE_NEWSTITLE,[dictionary valueForKey:CORE_NEWSTITLE]];
	if ([dictionary valueForKey:CORE_NEWSBODY])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",CORE_NEWSBODY,[dictionary valueForKey:CORE_NEWSBODY]];
	if ([dictionary valueForKey:CORE_NEWSDATE])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",CORE_NEWSDATE,[dictionary valueForKey:CORE_NEWSDATE]];
	if ([dictionary valueForKey:CORE_NEWSSOURCE])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",CORE_NEWSSOURCE,[dictionary valueForKey:CORE_NEWSSOURCE]];
	if ([dictionary valueForKey:COMMENT_ID])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",COMMENT_ID,[dictionary valueForKey:COMMENT_ID]];
	if ([dictionary valueForKey:COMMENT_PARENTID])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",COMMENT_PARENTID,[dictionary valueForKey:COMMENT_PARENTID]];
	if ([dictionary valueForKey:COMMENT_COMMENTER])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",COMMENT_COMMENTER,[dictionary valueForKey:COMMENT_COMMENTER]];
	if ([dictionary valueForKey:COMMENT_LOCATION])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",COMMENT_LOCATION,[dictionary valueForKey:COMMENT_LOCATION]];
	if ([dictionary valueForKey:COMMENT_DATE])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",COMMENT_DATE,[dictionary valueForKey:COMMENT_DATE]];
	if ([dictionary valueForKey:COMMENT_LIKECOMMENT])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",COMMENT_LIKECOMMENT,[dictionary valueForKey:COMMENT_LIKECOMMENT]];
	if ([dictionary valueForKey:COMMENT_DISLIKECOMMENT])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",COMMENT_DISLIKECOMMENT,[dictionary valueForKey:COMMENT_DISLIKECOMMENT]];
	if ([dictionary valueForKey:COMMENT_RESPONSECOUNT])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",COMMENT_RESPONSECOUNT,[dictionary valueForKey:COMMENT_RESPONSECOUNT]];
	if ([dictionary valueForKey:COMMENT_BODY])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",COMMENT_BODY,[dictionary valueForKey:COMMENT_BODY]];
	if ([dictionary valueForKey:CATEGORY_NEWS])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",CATEGORY_NEWS,[dictionary valueForKey:CATEGORY_NEWS]];
	if ([dictionary valueForKey:LABEL_NEWS])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",LABEL_NEWS,[dictionary valueForKey:LABEL_NEWS]];
	if ([dictionary valueForKey:OPERATOR])
		queryString = [queryString stringByAppendingFormat:@"%@=%@&",OPERATOR,[dictionary valueForKey:OPERATOR]];

	NSString *newString = @"";
	if (queryString.length > 0)
		newString = [queryString substringToIndex:[queryString length]-1];
	
	NSLog(@"SearchString: %@",newString);
	
	return newString;
}

+ (NSArray *)arrayOfComponentLabels {
	
	NSMutableArray *array = [NSMutableArray array];
	
	[array addObject:@"CORE NEWSURL"];
	[array addObject:@"CORE NEWSNUMBER"];
	[array addObject:@"CORE NEWSTITLE"];
	[array addObject:@"CORE NEWSBODY"];
	[array addObject:@"CORE NEWSDATE"];
	[array addObject:@"CORE NEWSSOURCE"];
	[array addObject:@"COMMENT ID"];
	[array addObject:@"COMMENT PARENTID"];
	[array addObject:@"COMMENT COMMENTER"];
	[array addObject:@"COMMENT LOCATION"];
	[array addObject:@"COMMENT DATE"];
	[array addObject:@"COMMENT LIKECOMMENT"];
	[array addObject:@"COMMENT DISLIKECOMMENT"];
	[array addObject:@"COMMENT RESPONSECOUNT"];
	[array addObject:@"COMMENT BODY"];
	[array addObject:@"CATEGORY NEWS"];
	[array addObject:@"LABEL NEWS"];
	[array addObject:@"OPERATOR"];
	
	return (NSArray *)array;
}

+ (NSArray *)arrayOfComponentStringData {

	NSMutableArray *array = [NSMutableArray array];
	
	[array addObject:CORE_NEWSURL];
	[array addObject:CORE_NEWSNUMBER];
	[array addObject:CORE_NEWSTITLE];
	[array addObject:CORE_NEWSBODY];
	[array addObject:CORE_NEWSDATE];
	[array addObject:CORE_NEWSSOURCE];
	[array addObject:COMMENT_ID];
	[array addObject:COMMENT_PARENTID];
	[array addObject:COMMENT_COMMENTER];
	[array addObject:COMMENT_LOCATION];
	[array addObject:COMMENT_DATE];
	[array addObject:COMMENT_LIKECOMMENT];
	[array addObject:COMMENT_DISLIKECOMMENT];
	[array addObject:COMMENT_RESPONSECOUNT];
	[array addObject:COMMENT_BODY];
	[array addObject:CATEGORY_NEWS];
	[array addObject:LABEL_NEWS];
	[array addObject:OPERATOR];
	
	return (NSArray *)array;
}

@end
