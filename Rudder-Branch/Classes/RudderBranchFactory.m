//
//  RudderBranchFactory.m
//  Branch
//
//  Created by Arnab Pal on 10/01/20.
//

#import "RudderBranchFactory.h"
#import "RudderBranchIntegration.h"

@implementation RudderBranchFactory

+ (instancetype) instance {
    static RudderBranchFactory *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    return self;
}

- (nonnull id<RudderIntegration>)initiate:(nonnull NSDictionary *)config
                                   client:(nonnull RudderClient *)client
                             rudderConfig:(nonnull RudderConfig *)rudderConfig {
    return [[RudderBranchIntegration alloc] initWithConfig:config rudderClient:client rudderConfig:rudderConfig];
}

- (nonnull NSString *)key {
    return @"Branch Metrics";
}

@end
