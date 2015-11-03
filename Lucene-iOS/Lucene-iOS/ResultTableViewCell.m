//
//  ResultTableViewCell.m
//  Lucene-iOS
//
//  Created by Alireza Arabi on 11/3/15.
//  Copyright © 2015 Alireza Arabi. All rights reserved.
//

#import "ResultTableViewCell.h"

@implementation ResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)OpenURLAction:(id)sender {

	[[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.resultURL]];
}

@end
