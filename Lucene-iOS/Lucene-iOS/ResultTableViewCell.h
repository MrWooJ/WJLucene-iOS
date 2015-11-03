//
//  ResultTableViewCell.h
//  Lucene-iOS
//
//  Created by Alireza Arabi on 11/3/15.
//  Copyright © 2015 Alireza Arabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewCell : UITableViewCell

@property (strong, nonatomic) NSString *resultURL;

@property (strong, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)OpenURLAction:(id)sender;

@end
