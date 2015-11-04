//
//  ViewController.m
//  Lucene-iOS
//
//  Created by Alireza Arabi on 11/3/15.
//  Copyright © 2015 Alireza Arabi. All rights reserved.
//

#import "ViewController.h"
#import "UtilityHelper.h"
#import "SearchTableViewCell.h"
#import "ResultViewController.h"
#import "Rest API/RestAPI.h"

@interface ViewController () <RESTAPIDelegate, UITextFieldDelegate>
{
	NSUserDefaults *ud;
}
@property (strong, nonatomic) IBOutlet UITableView *searchTableView;

@property (strong, nonatomic) NSArray *placeHolders;
@property (strong, nonatomic) NSArray *identifiers;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[[RestAPI sharedService] setRestAPIDelegate:self];
	
	ud = [NSUserDefaults standardUserDefaults];
	
	self.placeHolders = [NSArray array];
	self.identifiers = [NSArray array];
	
	self.placeHolders = [UtilityHelper arrayOfComponentLabels];
	self.identifiers = [UtilityHelper arrayOfComponentStringData];
	
	[self.searchTableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SearchCellIdentifier"];
	[self.searchTableView setAllowsSelection:YES];
	
	UIView *whiteView = [[UIView alloc]initWithFrame:self.searchTableView.frame];
	whiteView.backgroundColor = [UIColor whiteColor];
	self.searchTableView.backgroundView = whiteView;
	
	[self setTitle:@"Search"];
	self.navigationController.navigationBar.translucent = NO;
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"Done"
								   style:UIBarButtonItemStylePlain
								   target:self
								   action:@selector(dismissKeyboardFromScreen)];
	
	self.navigationItem.leftBarButtonItem = doneButton;

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(dismissKeyboardFromScreen)];
	
	[self.view addGestureRecognizer:tap];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow:)
												 name:UIKeyboardWillShowNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHide:)
												 name:UIKeyboardWillHideNotification
											   object:nil];
	
	self.searchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	for (NSString *key in [UtilityHelper arrayOfComponentStringData])
		[ud removeObjectForKey:key];
	
	[ud synchronize];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return [[UtilityHelper arrayOfComponentLabels] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
}

- (SearchTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCellIdentifier"];
	
	if (cell == nil) {
		cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SearchCellIdentifier"];
	}
	
	[cell setSearchFieldIdentifier:[self.identifiers objectAtIndex:indexPath.row]];
	[cell.searchTextField setPlaceholder:[self.placeHolders objectAtIndex:indexPath.row]];
	[cell.searchTextField setDelegate:self];
	
	if ([ud valueForKey:cell.searchFieldIdentifier])
		[cell.searchTextField setText:[ud valueForKey:cell.searchFieldIdentifier]];
	else
		[cell.searchTextField setText:@""];
	
	[cell setUserInteractionEnabled:YES];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

#pragma mark - Button Handlers

- (IBAction)clearAction:(id)sender {

	for (NSString *key in [UtilityHelper arrayOfComponentStringData])
		[ud removeObjectForKey:key];
	
	[ud synchronize];
	
	[self.searchTableView reloadData];
}

- (IBAction)searchAction:(id)sender {

	NSString *query = [UtilityHelper produceQuery];
	[[RestAPI sharedService] getResultOfQuery:query];
}

#pragma mark - RESTApi Delegate

- (void)showResult:(NSDictionary *)resultsDictionary {
	
	NSString *status = [resultsDictionary valueForKey:@"Status"];
	
	if ([status isEqualToString:@"Successful"]) {
		
		ResultViewController *RVC = [[ResultViewController alloc]init];
		RVC.resultDictionry = resultsDictionary;
		UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:RVC];
		[self presentViewController:nav animated:YES completion:nil];
	}
	else {
		
		[self showAlertWithTitle:@"No Result" Message:@"Your Query has no Result."];
	}
}

- (void)showErrorMessage {
	
	[self showAlertWithTitle:@"Error" Message:@"Fetching Data Failed. Perhaps Service is not Available or Your Query is not right. Check and Retry!"];
}

- (void)showAlertWithTitle:(NSString *)title Message:(NSString *)msg {
	
	UIAlertController * alert =   [UIAlertController
								  alertControllerWithTitle:title
								  message:msg
								  preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* ok = [UIAlertAction
						 actionWithTitle:@"OK"
						 style:UIAlertActionStyleDefault
						 handler:^(UIAlertAction * action)
						 {
							 [alert dismissViewControllerAnimated:YES completion:nil];
							 
						 }];
	
	[alert addAction:ok];
	
	[self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Keyboard Handler

-(void)dismissKeyboardFromScreen {
	
	[self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
	CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	
	UIEdgeInsets contentInsets;
	if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
		contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
	} else {
		contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
	}
	
	self.searchTableView.contentInset = contentInsets;
	self.searchTableView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	self.searchTableView.contentInset = UIEdgeInsetsZero;
	self.searchTableView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

	[textField resignFirstResponder];
	return YES;
}


@end
