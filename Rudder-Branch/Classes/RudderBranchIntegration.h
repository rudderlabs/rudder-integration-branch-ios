//
//  RudderBranchIntegration.h
//  Branch
//
//  Created by Arnab Pal on 10/01/20.
//

#import <Foundation/Foundation.h>
#import <Rudder/Rudder.h>
#import "BranchSDK/BranchEvent.h"
#import "RudderUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface RudderBranchIntegration : NSObject<RSIntegration, BranchDelegate>

@property (nonatomic, strong) NSArray *predefinedKeys;
@property (nonatomic, strong) Branch *branchInstance;

- (instancetype) initWithConfig: (NSDictionary *) destinationConfig
                   rudderClient: (RSClient*) rudderClient
                  rudderConfig : (RSConfig*) rudderConfig;

@end

NS_ASSUME_NONNULL_END
