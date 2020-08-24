//
//  RudderBranchIntegration.h
//  Branch
//
//  Created by Arnab Pal on 10/01/20.
//

#import <Foundation/Foundation.h>
#import <Rudder/Rudder.h>
#import "Branch/Branch.h"

NS_ASSUME_NONNULL_BEGIN

@interface RudderBranchIntegration : NSObject<RSIntegration, BranchDelegate>

@property (nonatomic, strong) NSDictionary *config;
@property (nonatomic, strong) RSClient *client;
@property (nonatomic, strong) RSConfig *rudderConfig;
@property (nonatomic, strong) NSArray *predefinedKeys;

@property (nonatomic, strong) Branch *branchInstance;

- (instancetype) initWithConfig: (NSDictionary *) destinationConfig
                   rudderClient: (RSClient*) rudderClient
                  rudderConfig : (RSConfig*) rudderConfig;

@end

NS_ASSUME_NONNULL_END
