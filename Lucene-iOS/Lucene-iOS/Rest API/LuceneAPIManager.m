//
//  LiberatoAPIManager.m
//  Librato-V1
//
//  Created by Alireza Arabi on 9/30/15.
//  Copyright © 2015 Alireza Arabi. All rights reserved.
//

#import "LuceneAPIManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation LuceneAPIManager

#pragma mark - Methods

- (void)setUsername:(NSString *)username Password:(NSString *)password
{
	[self.requestSerializer clearAuthorizationHeader];
	[self.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
}

#pragma mark - Initialization

- (id)initWithBaseURL:(NSURL *)url
{
	self = [super initWithBaseURL:url];
	if(!self)
		return nil;
	
	self.requestSerializer = [AFJSONRequestSerializer serializer];
	
	[[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
	
	return self;
}

#pragma mark - Singleton Methods

+ (LuceneAPIManager *)sharedManager
{
	static dispatch_once_t pred;
	static LuceneAPIManager *_sharedManager = nil;
	
	dispatch_once(&pred, ^{
		_sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://0.0.0.0:8000"]];
//		_sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://192.168.1.4:8000"]];

	});
	
	return _sharedManager;
}

@end
