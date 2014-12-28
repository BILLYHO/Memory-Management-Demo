//
//  RootViewController.m
//  PropMemFun
//
//  Created by BILLY HO on 12/24/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "RootViewController.h"



@implementation RootViewController
@synthesize sushiTypes = _sushiTypes;
@synthesize lastSushiSelected = _lastSushiSelected;
- (void)viewDidLoad {
	[super viewDidLoad];
 
	self.sushiTypes = [[[NSArray alloc] initWithObjects:@"California Roll",
						@"Tuna Roll", @"Salmon Roll", @"Unagi Roll",
						@"Philadelphia Roll", @"Rainbow Roll",
						@"Vegetable Roll", @"Spider Roll",
						@"Shrimp Tempura Roll", @"Cucumber Roll",
						@"Yellowtail Roll", @"Spicy Tuna Roll",
						@"Avocado Roll", @"Scallop Roll",
						nil] autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _sushiTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell"];
	NSString * sushiName = [_sushiTypes objectAtIndex:indexPath.row]; // 1

	NSString * sushiString = [NSString stringWithFormat:@"%ld: %@",indexPath.row, sushiName]; // 2
	
	NSLog(@"%lu", [sushiString retainCount]);
	cell.textLabel.text = sushiString; // 3
	
	NSLog(@"%lu", [sushiString retainCount]);
	//[sushiString release]; // 4
	NSLog(@"%lu", [sushiString retainCount]);
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
	NSString * sushiName = [_sushiTypes objectAtIndex:indexPath.row]; // 1
	NSString * sushiString = [NSString stringWithFormat:@"%ld: %@",
							  indexPath.row, sushiName]; // 2
 
	NSString * message = [NSString stringWithFormat:@"Last sushi: %@.  Cur sushi: %@", _lastSushiSelected, sushiString]; // 3
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Sushi Power!"
														 message:message
														delegate:nil
											   cancelButtonTitle:nil
											   otherButtonTitles:@"OK", nil] autorelease]; // 4
	[alertView show]; // 5
 
	[_lastSushiSelected release]; // 6
	_lastSushiSelected = [sushiString retain]; // 7
 
}

- (void)viewDidUnload {
	self.sushiTypes = nil;
}

- (void)dealloc {
	[_sushiTypes release];
	_sushiTypes = nil;
	[_lastSushiSelected release];
	_lastSushiSelected = nil;
	[super dealloc];
}

@end
