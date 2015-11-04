//
//  SearchTableViewCell.m
//  Lucene-iOS
//
//  Created by Alireza Arabi on 11/3/15.
//  Copyright © 2015 Alireza Arabi. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addAction:(id)sender {

	if (![self.searchTextField.text isEqualToString:@""]) {
		
		[self.searchTextField setTextColor:[UIColor greenColor]];
		
		NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
		[ud setValue:self.searchTextField.text forKey:self.searchFieldIdentifier];
		[ud synchronize];
	}
}

@end
