//
//  _ViewController.m
//  Rudder-Branch
//
//  Created by arnab on 01/09/2020.
//  Copyright (c) 2020 arnab. All rights reserved.
//

#import "_ViewController.h"
#import <RudderSDKCore/RudderSDKCore.h>

@interface _ViewController ()

@end

@implementation _ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[RudderClient sharedInstance] track:@"some_track_event"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
