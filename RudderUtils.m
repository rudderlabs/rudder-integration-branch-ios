//
//  RudderUtils.m
//  Rudder-Branch
//
//  Created by Abhishek Pandey on 23/11/23.
//

#import <Foundation/Foundation.h>
#import "RudderUtils.h"
#import "BranchSDK/BNCProductCategory.h"

@implementation RudderUtils

+ (BOOL)isEmpty:(NSString *)value {
    return value == nil || [value length] == 0;
}

+(NSString*)truncateUserIdIfExceedsLimit:(NSString*)userId andLimit:(int)limit{
    if([userId length] > limit) {
        userId = [[userId substringToIndex:limit] mutableCopy];
    }
    return userId;
}

+(BNCProductCategory) getProductCategory:(NSString*)category {
    if (category == nil) {
        return nil;
    }
    
    if ([category isEqualToString:@"Animals & Pet Supplies"]) {
        return BNCProductCategoryAnimalSupplies;
    } else if ([category isEqualToString:@"Apparel & Accessories"]) {
        return BNCProductCategoryApparel;
    } else if ([category isEqualToString:@"Arts & Entertainment"]) {
        return BNCProductCategoryArtsEntertainment;
    } else if ([category isEqualToString:@"Baby & Toddler"]) {
        return BNCProductCategoryBabyToddler;
    } else if ([category isEqualToString:@"Business & Industrial"]) {
        return BNCProductCategoryBusinessIndustrial;
    } else if ([category isEqualToString:@"Cameras & Optics"]) {
        return BNCProductCategoryCamerasOptics;
    } else if ([category isEqualToString:@"Electronics"]) {
        return BNCProductCategoryElectronics;
    } else if ([category isEqualToString:@"Food, Beverages & Tobacco"]) {
        return BNCProductCategoryFoodBeverageTobacco;
    } else if ([category isEqualToString:@"Furniture"]) {
        return BNCProductCategoryFurniture;
    } else if ([category isEqualToString:@"Hardware"]) {
        return BNCProductCategoryHardware;
    } else if ([category isEqualToString:@"Health & Beauty"]) {
        return BNCProductCategoryHealthBeauty;
    } else if ([category isEqualToString:@"Home & Garden"]) {
        return BNCProductCategoryHomeGarden;
    } else if ([category isEqualToString:@"Luggage & Bags"]) {
        return BNCProductCategoryLuggageBags;
    } else if ([category isEqualToString:@"Mature"]) {
        return BNCProductCategoryMature;
    } else if ([category isEqualToString:@"Media"]) {
        return BNCProductCategoryMedia;
    } else if ([category isEqualToString:@"Office Supplies"]) {
        return BNCProductCategoryOfficeSupplies;
    } else if ([category isEqualToString:@"Religious & Ceremonial"]) {
        return BNCProductCategoryReligious;
    } else if ([category isEqualToString:@"Software"]) {
        return BNCProductCategorySoftware;
    } else if ([category isEqualToString:@"Sporting Goods"]) {
        return BNCProductCategorySportingGoods;
    } else if ([category isEqualToString:@"Toys & Games"]) {
        return BNCProductCategoryToysGames;
    } else if ([category isEqualToString:@"Vehicles & Parts"]) {
        return BNCProductCategoryVehiclesParts;
    } else {
        return nil;
    }
}

@end
