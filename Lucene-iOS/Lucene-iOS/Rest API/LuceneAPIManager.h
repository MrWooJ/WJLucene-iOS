//
//  LiberatoAPIManager.h
//  Librato-V1
//
//  Created by Alireza Arabi on 9/30/15.
//  Copyright © 2015 Alireza Arabi. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface LuceneAPIManager : AFHTTPRequestOperationManager

- (void)setUsername:(NSString *)username Password:(NSString *)password;

+ (LuceneAPIManager *)sharedManager;

@end
