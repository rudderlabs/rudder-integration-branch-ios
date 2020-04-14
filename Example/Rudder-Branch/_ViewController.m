//
//  _ViewController.m
//  Rudder-Branch
//
//  Created by arnab on 01/09/2020.
//  Copyright (c) 2020 arnab. All rights reserved.
//

#import "_ViewController.h"
#import <Rudder/Rudder.h>

@interface _ViewController ()

@end

@implementation _ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[RudderClient sharedInstance] track:@"some_track_event"];
    [[RudderClient sharedInstance] track:@"Add To Cart" properties:@{@"price": @2.0, @"product_id": @"product_id_a", @"product_name": @"Product Name A"}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)_onClickButton:(id)sender {
    
}

@end
