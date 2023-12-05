//
//  RudderBranchIntegration.m
//  Branch
//
//  Created by Arnab Pal on 10/01/20.
//

#import "RudderBranchIntegration.h"

@implementation RudderBranchIntegration

- (instancetype)initWithConfig: (NSDictionary *) destinationConfig
                  rudderClient: (RSClient *) rudderClient
                  rudderConfig: (RSConfig *) rudderConfig {
    
    if (self == [super init]) {
        self.predefinedKeys = [NSArray arrayWithObjects:
                               @"cart_id",
                               @"wishlist_id",
                               @"wishlist_name",
                               @"products",
                               @"cart_id",
                               @"affiliation",
                               @"currency",
                               @"coupon",
                               @"revenue",
                               @"shipping",
                               @"tax",
                               @"order_id",
                               @"price",
                               @"brand",
                               @"name",
                               @"category",
                               @"sku",
                               @"quantity",
                               @"variant",
                               @"product_id",
                               @"rating",
                               @"query",
                               nil
        ];
        
        NSString *branchKey = [destinationConfig objectForKey:@"branchKey"];
        if ([RudderUtils isEmpty:branchKey] == YES) {
            [RSLogger logError:@"RudderBranchIntegration: Branch Key is empty. Aborting initialization."];
            return nil;
        }
        _branchInstance = [Branch getInstance:branchKey];
        [RSLogger logDebug:@"RudderBranchIntegration: Branch SDK initialized."];
        // Logging should be done after the Branch SDK gets initialized
        if (rudderConfig.logLevel >= RSLogLevelDebug) {
            [_branchInstance enableLogging];
        }
    }
    
    return self;
}

- (void)dump:(nonnull RSMessage *)message {
    if (message == nil) {
        return;
    }
    
    NSString *eventType = message.type;
    
    if ([eventType isEqualToString:@"identify"]) {
        NSString *userId = [message.userId mutableCopy];
        if ([RudderUtils isEmpty:userId] == YES) {
            [RSLogger logDebug:@"RudderBranchIntegration: User Id is empty. Aborting identify event."];
            return;
        }
        userId = [RudderUtils truncateUserIdIfExceedsLimit:userId andLimit:127];
        [_branchInstance setIdentity:userId];
    } else if ([eventType isEqualToString:@"track"]) {
        NSString *eventName = message.event;
        if (eventName != nil) {
                // Commerce Events
            if ([eventName isEqualToString:@"Product Added"]) {
                BranchContentMetadata *pa_cmd = [self getSingleProductMetaData:message.properties];
                BranchUniversalObject *pa_buo = [[BranchUniversalObject alloc] init];
                [pa_buo setContentMetadata:pa_cmd];
                BranchEvent *pa_be = [BranchEvent standardEvent:BranchStandardEventAddToCart withContentItem:pa_buo];
                [self logEventToBranch:pa_be property:message.properties];
            } else if ([eventName isEqualToString:@"Product Added to Wishlist"]) {
                BranchEvent *pawl_be = [BranchEvent standardEvent:BranchStandardEventAddToWishlist];
                [self logEventToBranch:pawl_be property:message.properties];
            } else if ([eventName isEqualToString:@"Cart Viewed"]) {
                BranchEvent *cv_be = [BranchEvent standardEvent:BranchStandardEventViewCart];
                [self appendOrderProperty:cv_be property:message.properties];
                [self logEventToBranch:cv_be property:message.properties];
            } else if ([eventName isEqualToString:@"Checkout Started"]) {
                BranchEvent *cs_be = [BranchEvent standardEvent:BranchStandardEventInitiatePurchase];
                [self appendOrderProperty:cs_be property:message.properties];
                [self logEventToBranch:cs_be property:message.properties];
            } else if ([eventName isEqualToString:@"Payment Info Entered"]) {
                BranchEvent *pie_be = [BranchEvent standardEvent:BranchStandardEventAddPaymentInfo];
                [self appendOrderProperty:pie_be property:message.properties];
                [self logEventToBranch:pie_be property:message.properties];
            } else if ([eventName isEqualToString:@"Order Completed"]) {
                BranchEvent *oc_be = [BranchEvent standardEvent:BranchStandardEventPurchase];
                [self appendOrderProperty:oc_be property:message.properties];
                [self logEventToBranch:oc_be property:message.properties];
            } else if ([eventName isEqualToString:@"Spend Credits"]) {
                BranchEvent *sc_be = [BranchEvent standardEvent:BranchStandardEventSpendCredits];
                [self appendOrderProperty:sc_be property:message.properties];
                [self logEventToBranch:sc_be property:message.properties];
            } else if ([eventName isEqualToString:@"Promotion Viewed"]) {
                BranchEvent *pv_be = [BranchEvent standardEvent:BranchStandardEventViewAd];
                [self logEventToBranch:pv_be property:message.properties];
            } else if ([eventName isEqualToString:@"Promotion Clicked"]) {
                BranchEvent *pc_be = [BranchEvent standardEvent:BranchStandardEventClickAd];
                [self logEventToBranch:pc_be property:message.properties];
            } else if ([eventName isEqualToString:@"Reserve"]) {
                BranchEvent *r_be = [BranchEvent standardEvent:BranchStandardEventReserve];
                [self logEventToBranch:r_be property:message.properties];
            }
                // Content Events
            else if ([eventName isEqualToString:@"Products Searched"]) {
                NSMutableArray *keywords = [[NSMutableArray alloc] init];
                NSObject *keyword = [message.properties objectForKey:@"query"];
                if (keyword != nil) {
                    [keywords addObject:[[NSString alloc] initWithFormat:@"%@", keyword]];
                }
                BranchEvent *ps_be = [BranchEvent standardEvent:BranchStandardEventSearch];
                BranchUniversalObject *ps_buo = [[BranchUniversalObject alloc] init];
                [ps_buo setKeywords:keywords];
                [ps_be setContentItems:[[NSArray alloc] initWithObjects:ps_buo, nil]];
                [self logEventToBranch:ps_be property:message.properties];
            } else if ([eventName isEqualToString:@"Product Viewed"]) {
                BranchEvent *pv_be = [BranchEvent standardEvent:BranchStandardEventViewItem];
                BranchUniversalObject *pv_buo = [[BranchUniversalObject alloc] init];
                [pv_buo setContentMetadata:[self getSingleProductMetaData:message.properties]];
                [pv_be setContentItems:[[NSArray alloc] initWithObjects:pv_buo, nil]];
                [self logEventToBranch:pv_be property:message.properties];
            } else if ([eventName isEqualToString:@"Product List Viewed"]) {
                BranchEvent *plv_be = [BranchEvent standardEvent:BranchStandardEventViewItems];
                [self appendOrderProperty:plv_be property:message.properties];
                [self logEventToBranch:plv_be property:message.properties];
            } else if ([eventName isEqualToString:@"Product Reviewed"]) {
                BranchEvent *pr_be = [BranchEvent standardEvent:BranchStandardEventRate];
                BranchUniversalObject *pr_buo = [[BranchUniversalObject alloc] init];
                [pr_buo setContentMetadata:[self getSingleProductMetaData:message.properties]];
                [pr_be setContentItems:[[NSArray alloc] initWithObjects:pr_buo, nil]];
                [self logEventToBranch:pr_be property:message.properties];
            } else if ([eventName isEqualToString:@"Product Shared"]) {
                BranchEvent *prs_be = [BranchEvent standardEvent:BranchStandardEventShare];
                BranchUniversalObject *prs_buo = [[BranchUniversalObject alloc] init];
                [prs_buo setContentMetadata:[self getSingleProductMetaData:message.properties]];
                [prs_be setContentItems:[[NSArray alloc] initWithObjects:prs_buo, nil]];
                [self logEventToBranch:prs_be property:message.properties];
            } else if ([eventName isEqualToString:@"Initiate Stream"]) {
                BranchEvent *is_be = [BranchEvent standardEvent:BranchStandardEventInitiateStream];
                [self logEventToBranch:is_be property:message.properties];
            } else if ([eventName isEqualToString:@"Complete Stream"]) {
                BranchEvent *cs_be = [BranchEvent standardEvent:BranchStandardEventCompleteStream];
                [self logEventToBranch:cs_be property:message.properties];
            }
                // Lifecycle Events
            else if ([eventName isEqualToString:@"Complete Registration"]) {
                BranchEvent *cr_be = [BranchEvent standardEvent:BranchStandardEventCompleteRegistration];
                [self logEventToBranch:cr_be property:message.properties];
            } else if ([eventName isEqualToString:@"Complete Tutorial"]) {
                BranchEvent *ct_be = [BranchEvent standardEvent:BranchStandardEventCompleteTutorial];
                [self logEventToBranch:ct_be property:message.properties];
            } else if ([eventName isEqualToString:@"Achieve Level"]) {
                BranchEvent *al_be = [BranchEvent standardEvent:BranchStandardEventAchieveLevel];
                [self logEventToBranch:al_be property:message.properties];
            } else if ([eventName isEqualToString:@"Unlock Achievement"]) {
                BranchEvent *ua_be = [BranchEvent standardEvent:BranchStandardEventUnlockAchievement];
                [self logEventToBranch:ua_be property:message.properties];
            } else if ([eventName isEqualToString:@"Invite"]) {
                BranchEvent *i_be = [BranchEvent standardEvent:BranchStandardEventInvite];
                [self logEventToBranch:i_be property:message.properties];
            } else if ([eventName isEqualToString:@"Login"]) {
                BranchEvent *l_be = [BranchEvent standardEvent:BranchStandardEventLogin];
                [self logEventToBranch:l_be property:message.properties];
            } else if ([eventName isEqualToString:@"Start Trial"]) {
                BranchEvent *st_be = [BranchEvent standardEvent:BranchStandardEventStartTrial];
                [self logEventToBranch:st_be property:message.properties];
            } else if ([eventName isEqualToString:@"Subscribe"]) {
                BranchEvent *s_be = [BranchEvent standardEvent:BranchStandardEventSubscribe];
                [self logEventToBranch:s_be property:message.properties];
            }
                // Custom events
            else {
                BranchEvent *ge_be = [BranchEvent customEventWithName:eventName];
                [self logEventToBranch:ge_be property:message.properties];
            }
        }
    } else if ([eventType isEqualToString:@"screen"]) {
        
    }
}

- (void)reset {
    [_branchInstance logout];
}

- (void)flush { 
    // Branch SDK doesn't support flush
}


- (BranchContentMetadata*) getSingleProductMetaData : (NSDictionary*) property {
    BranchContentMetadata *cmd = [[BranchContentMetadata alloc] init];

    NSDecimalNumber *price = [property objectForKey:@"price"];
    if (price != nil) {
        [cmd setPrice:price];
    }
    NSObject *currency = [property objectForKey:@"currency"];
    if (currency != nil) {
        [cmd setCurrency:[[NSString alloc] initWithFormat:@"%@", currency]];
    }
    NSObject *brand = [property objectForKey:@"brand"];
    if (brand != nil) {
        [cmd setProductBrand:[[NSString alloc] initWithFormat:@"%@", brand]];
    }
    NSObject *name = [property objectForKey:@"name"];
    if (name != nil) {
        [cmd setProductName:[[NSString alloc] initWithFormat:@"%@", name]];
    }
    NSObject *category = [property objectForKey:@"category"];
    if (category != nil) {
        [cmd setProductCategory:[RudderUtils getProductCategory:[NSString stringWithFormat:@"%@", category]]];
    }
//    give sku higher priority. if sku is not present take productid as sku
    NSObject *sku = [property objectForKey:@"sku"];
    NSObject *productId = [property objectForKey:@"product_id"];
    if (sku != nil) {
        [cmd setSku:[[NSString alloc] initWithFormat:@"%@", sku]];
    } else if (productId != nil) {
        [cmd setSku:[[NSString alloc] initWithFormat:@"%@", productId]];
    }
    NSObject *quantity = [property objectForKey:@"quantity"];
    if (quantity != nil) {
        [cmd setQuantity:[self convertToDecimal:quantity]];
    }
    NSObject *variant = [property objectForKey:@"variant"];
    if (variant != nil) {
        [cmd setProductVariant:[[NSString alloc] initWithFormat:@"%@", variant]];
    }
    NSObject *rating = [property objectForKey:@"rating"];
    if (rating != nil) {
        [cmd setRating:[self convertToDecimal:rating]];
    }
    return cmd;
}

- (BranchEvent*) appendOrderProperty: (BranchEvent*) be property:(NSDictionary*) property {
    NSMutableArray *buos = [[NSMutableArray alloc] init];
    NSArray *products = (NSArray*) [property objectForKey:@"products"];
    if (products != nil) {
        for (NSDictionary *product in products) {
            BranchContentMetadata *cmd = [self getSingleProductMetaData:product];
            BranchUniversalObject *buo = [[BranchUniversalObject alloc] init];
            [buo setContentMetadata:cmd];
            [buos addObject:buo];
        }
    }
    if ([buos count] > 0) {
        [be setContentItems:buos];
    }
    NSObject *affiliation = [property objectForKey:@"affiliation"];
    if (affiliation != nil) {
        [be setAffiliation:[[NSString alloc] initWithFormat:@"%@", affiliation]];
    }
    NSObject *currency = [property objectForKey:@"currency"];
    if (currency != nil) {
        [be setCurrency:[[NSString alloc] initWithFormat:@"%@", currency]];
    }
    NSObject *coupon = [property objectForKey:@"coupon"];
    if (coupon != nil) {
        [be setCoupon:[[NSString alloc] initWithFormat:@"%@", coupon]];
    }
    NSObject *revenue = [property objectForKey:@"revenue"];
    if (revenue != nil) {
        [be setRevenue:[self convertObjectToDecimal:revenue]];
    }
    NSObject *shipping = [property objectForKey:@"shipping"];
    if (shipping != nil) {
        [be setShipping:[self convertObjectToDecimal:shipping]];
    }
    NSObject *tax = [property objectForKey:@"tax"];
    if (tax != nil) {
        [be setTax:[self convertObjectToDecimal:tax]];
    }
    NSObject *order_id = [property objectForKey:@"order_id"];
    if (order_id != nil) {
        [be setTransactionID:[[NSString alloc] initWithFormat:@"%@", order_id]];
    }
    
    return be;
}

- (void) logEventToBranch: (BranchEvent*) be property:(NSDictionary*) property {
    if (property != nil) {
        NSArray *keySet = [property allKeys];
        NSMutableDictionary * custom_dict = [[NSMutableDictionary alloc] init];
        for (NSString *key in keySet) {
            if (![self.predefinedKeys containsObject:key]) {
                [custom_dict setObject:[property objectForKey:key] forKey:key];
            }
        }
        [be setCustomData:custom_dict];
    }
    [be logEvent];
}

- (NSDecimalNumber*) convertObjectToDecimal: (id) value {
    if ([value isKindOfClass:[NSNumber class]]) {
        return [[NSDecimalNumber alloc] initWithDouble:[value doubleValue]];
    }
    return nil;
}

- (double) convertToDecimal: (id) value {
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value doubleValue];
    }
    return -1;
}
@end
