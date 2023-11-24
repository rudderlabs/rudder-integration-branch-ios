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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Commerce Events
- (IBAction)productAdded:(id)sender {
    [[RSClient getInstance] track:@"Product Added" properties:[self getSingleProductPropertiesWithCustomProperties]];
}
- (IBAction)productAddedToWishList:(id)sender {
    [[RSClient getInstance] track:@"Product Added to Wishlist" properties:[self getCustomProperties]];
}
- (IBAction)cartViewed:(id)sender {
    [[RSClient getInstance] track:@"Cart Viewed" properties:[self getMultipleProductProperties]];
}
- (IBAction)checkoutStarted:(id)sender {
    [[RSClient getInstance] track:@"Checkout Started" properties:[self getMultipleProductProperties]];
}
- (IBAction)paymentInfoEntered:(id)sender {
    [[RSClient getInstance] track:@"Payment Info Entered" properties:[self getMultipleProductProperties]];
}
- (IBAction)orderCompleted:(id)sender {
    [[RSClient getInstance] track:@"Order Completed" properties:[self getMultipleProductProperties]];
}
- (IBAction)spendCredits:(id)sender {
    [[RSClient getInstance] track:@"Spend Credits" properties:[self getMultipleProductProperties]];
}
- (IBAction)promotionViewed:(id)sender {
    [[RSClient getInstance] track:@"Promotion Viewed" properties:[self getCustomProperties]];
}
- (IBAction)promotionClicked:(id)sender {
    [[RSClient getInstance] track:@"Promotion Clicked" properties:[self getCustomProperties]];
}
- (IBAction)reserve:(id)sender {
    [[RSClient getInstance] track:@"Reserve" properties:[self getCustomProperties]];
}

// Content Events
- (IBAction)productsSearched:(id)sender {
    [[RSClient getInstance] track:@"Products Searched" properties:[self getEComProperties]];
}
- (IBAction)productViewed:(id)sender {
    [[RSClient getInstance] track:@"Product Viewed" properties:[self getSingleProductPropertiesWithCustomProperties]];
}
- (IBAction)productListViewed:(id)sender {
    [[RSClient getInstance] track:@"" properties:[self getMultipleProductProperties]];
}
- (IBAction)productReviewed:(id)sender {
    [[RSClient getInstance] track:@"Product Reviewed" properties:[self getSingleProductPropertiesWithCustomProperties]];
}
- (IBAction)productShared:(id)sender {
    [[RSClient getInstance] track:@"Product Shared" properties:[self getSingleProductPropertiesWithCustomProperties]];
}
- (IBAction)initiateStream:(id)sender {
    [[RSClient getInstance] track:@"Initiate Stream" properties:[self getCustomProperties]];
}
- (IBAction)completeStream:(id)sender {
    [[RSClient getInstance] track:@"Complete Stream" properties:[self getCustomProperties]];
}

// Lifecycle Events
- (IBAction)completeRegistration:(id)sender {
    [[RSClient getInstance] track:@"Complete Registration" properties:[self getCustomProperties]];
}
- (IBAction)completeTutorial:(id)sender {
    [[RSClient getInstance] track:@"Complete Tutorial" properties:[self getCustomProperties]];
}
- (IBAction)achieveLevel:(id)sender {
    [[RSClient getInstance] track:@"Achieve Level" properties:[self getCustomProperties]];
}
- (IBAction)unlockAchievement:(id)sender {
    [[RSClient getInstance] track:@"Unlock Achievement" properties:[self getCustomProperties]];
}
- (IBAction)invite:(id)sender {
    [[RSClient getInstance] track:@"Invite" properties:[self getCustomProperties]];
}
- (IBAction)login:(id)sender {
    [[RSClient getInstance] track:@"Login" properties:[self getCustomProperties]];
}
- (IBAction)startTrial:(id)sender {
    [[RSClient getInstance] track:@"Start Trial" properties:[self getCustomProperties]];
}
- (IBAction)subscribe:(id)sender {
    [[RSClient getInstance] track:@"Subscribe" properties:[self getCustomProperties]];
}

// Custom Events
- (IBAction)customTrackWithoutProperties:(id)sender {
    [[RSClient getInstance] track:@"Custom Track Without Properties"];
}
- (IBAction)customTrackWithProperties:(id)sender {
    [[RSClient getInstance] track:@"Custom Track With Properties" properties:[self getCustomProperties]];
}

// Identify
- (IBAction)identify:(id)sender {
    [[RSClient getInstance] identify:@"iOS userId"];
}

// Reset
- (IBAction)reset:(id)sender {
    [[RSClient getInstance] reset:YES];
}

// Properties handling
- (NSDictionary*) getMultipleProductProperties {
    NSDictionary *product1 = @{
        @"price": @154.79,
        @"currency": @"USD",
        @"brand": @"some_brand_1",
        @"name": @"some_name_1",
        @"category": @"Animals & Pet Supplies", // Make sure this is a valid value, refer to the Branch "ProductCategory" class.
        @"sku": @"some_sku_1",
        @"product_id": @"some_product_id_1",
        @"quantity": @10.0,
        @"variant": @"some_variant_1",
        @"rating": @4.5
    };
    
    NSDictionary *product2 = @{
        @"price": @254.79,
        @"currency": @"INR",
        @"brand": @"some_brand_2",
        @"name": @"some_name_2",
        @"category": @"Animals & Pet Supplies", // Make sure this is a valid value, refer to the Branch "ProductCategory" class.
        @"sku": @"some_sku_2",
        @"product_id": @"some_product_id_2",
        @"quantity": @20.0,
        @"variant": @"some_variant_2",
        @"rating": @3.5
    };
    
    NSArray *products = @[product1, product2];
    
    NSDictionary *property = @{
        @"products": products,
        
        @"affiliation": @"some_affiliation",
        @"currency": @"USD",
        @"coupon": @"some_coupon",
        @"revenue": @754.79,
        @"shipping": @100.0,
        @"tax": @5.0,
        @"order_id": @"some_order_id",
        @"query": @"some_query",
        
        @"key-1": @"value-1",
        @"key-2": @123
    };
    
    return property;
}

- (NSDictionary*) getEComProperties {
    NSDictionary *property = @{
        @"affiliation": @"some_affiliation",
        @"currency": @"USD",
        @"coupon": @"some_coupon",
        @"revenue": @754.79,
        @"shipping": @100.0,
        @"tax": @5.0,
        @"order_id": @"some_order_id",
        @"query": @"some_query",
        
        @"key-1": @"value-1",
        @"key-2": @123
    };
    
    return property;
}

- (NSDictionary*) getSingleProductPropertiesWithCustomProperties {
    NSDictionary *property = @{
        @"price": @154.79,
        @"currency": @"USD",
        @"brand": @"some_brand",
        @"name": @"some_name",
        @"category": @"Animals & Pet Supplies", // Make sure this is a valid value, refer to the Branch "ProductCategory" class.
        @"sku": @"some_sku",
        @"product_id": @"some_product_id",
        @"quantity": @10.0,
        @"variant": @"some_variant",
        @"rating": @4.5,
        
        @"key-1": @"value-1",
        @"key-2": @123
    };
    return property;
}

- (NSDictionary*) getCustomProperties {
    NSDictionary *property = @{
        @"key-1": @"value-1",
        @"key-2": @123
    };
    return property;
}

//[[RSClient getInstance] ];
@end
