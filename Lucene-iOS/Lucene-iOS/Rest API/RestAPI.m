//
//  RestAPI.m
//  WJLibrato
//
//  Created by Alireza Arabi on 9/30/15.
//  Copyright © 2015 Alireza Arabi. All rights reserved.
//

#import "RestAPI.h"

@interface RestAPI ()


@end

@implementation RestAPI

+ (RestAPI *)sharedService
{
	static RestAPI* sharedRestService = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		
		sharedRestService = [self new];
		
	});
	
	return sharedRestService;
}

#pragma mark __METRICS__

- (void)getResultOfQuery:(NSString *)query {

	__block NSDictionary *metrics = [NSDictionary dictionary];
	
	NSString *queryString = [[NSString stringWithFormat:@"search?%@",query]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	
	NSLog(@"QUERY: %@",query);
	
	[[LuceneAPIManager sharedManager] GET:queryString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		
		metrics = [NSDictionary dictionaryWithDictionary:responseObject];
		
		[_restAPIDelegate showResult:metrics];
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		
		NSLog(@"ERROR: %@", error);
		
		[_restAPIDelegate showErrorMessage];
		
	}];
}

@end
