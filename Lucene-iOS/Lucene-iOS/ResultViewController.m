//
//  ResultViewController.m
//  Lucene-iOS
//
//  Created by Alireza Arabi on 11/3/15.
//  Copyright © 2015 Alireza Arabi. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultTableViewCell.h"

@interface ResultViewController ()

@property (strong, nonatomic) NSMutableArray *resultArray;

@end

@implementation ResultViewController

- (id)init {
	
	NSString *nibName = @"ResultViewController";
	NSBundle *bundle = nil;
	
	self = [super initWithNibName:nibName bundle:bundle];
	
	if (self) {
		
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

	self.resultArray = [NSMutableArray array];
	[self dictionaryToArray];
	
	self.view.backgroundColor = [UIColor whiteColor];
	self.resultTableView.backgroundColor = [UIColor whiteColor];
	
	[self.resultTableView setDelegate:self];
	[self.resultTableView setDataSource:self];
	
	[self.resultTableView registerNib:[UINib nibWithNibName:@"ResultTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ResultCellIdentifier"];
	[self.resultTableView setAllowsSelection:YES];
	
	UIView *whiteView = [[UIView alloc]initWithFrame:self.resultTableView.frame];
	whiteView.backgroundColor = [UIColor whiteColor];
	self.resultTableView.backgroundView = whiteView;
	
	[self setTitle:@"Result"];
	self.navigationController.navigationBar.translucent = NO;
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"Back"
								   style:UIBarButtonItemStylePlain
								   target:self
								   action:@selector(backToRoot:)];
	
	self.navigationItem.leftBarButtonItem = backButton;
	
	self.resultTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [self.resultArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
}

- (ResultTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCellIdentifier"];
	
	if (cell == nil) {
		cell = [[ResultTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ResultCellIdentifier"];
	}
	
	NSDictionary *dict = [self.resultArray objectAtIndex:indexPath.row];
	
	
	[cell.resultLabel setText:[NSString stringWithFormat:@"NEWS NUMBER: %@",[dict valueForKey:@"Number"]]];
	cell.resultURL = [dict valueForKey:@"URL"];
	
	[cell setUserInteractionEnabled:YES];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

#pragma mark - Back Action

- (void)backToRoot:(id)sender {
	
	id viewController = [self.navigationController popViewControllerAnimated:YES];
	if (!viewController)
		[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setting

- (void)dictionaryToArray {
	
	self.resultArray = [self.resultDictionry valueForKey:@"News"];
}

@end
