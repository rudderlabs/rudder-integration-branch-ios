//
//  RudderBranchIntegration.h
//  Branch
//
//  Created by Arnab Pal on 10/01/20.
//

#import <Foundation/Foundation.h>
#import <RudderSDKCore/RudderIntegration.h>
#import <RudderSDKCore/RudderClient.h>
#import <RudderSDKCore/RudderConfig.h>
#import "Branch/Branch.h"

NS_ASSUME_NONNULL_BEGIN

@interface RudderBranchIntegration : NSObject<RudderIntegration, BranchDelegate>

@property (nonatomic, strong) NSDictionary *config;
@property (nonatomic, strong) RudderClient *client;
@property (nonatomic, strong) RudderConfig *rudderConfig;
@property (nonatomic, strong) NSArray *predefinedKeys;

@property (nonatomic, strong) Branch *branchInstance;

- (instancetype) initWithConfig: (NSDictionary *) destinationConfig
                   rudderClient: (RudderClient*) rudderClient
                  rudderConfig : (RudderConfig*) rudderConfig;

@end

NS_ASSUME_NONNULL_END
