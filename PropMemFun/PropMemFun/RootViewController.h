//
//  RootViewController.h
//  PropMemFun
//
//  Created by BILLY HO on 12/24/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController
{
	NSArray * _sushiTypes;
	NSString * _lastSushiSelected;
}

@property (nonatomic, retain) NSArray * sushiTypes;
@property (nonatomic, retain) NSString * lastSushiSelected;

@end
