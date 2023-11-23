//
//  RudderUtils.h
//  Rudder-Branch
//
//  Created by Abhishek Pandey on 23/11/23.
//

#ifndef RudderUtils_h
#define RudderUtils_h

@interface RudderUtils : NSObject

+(BOOL)isEmpty:(NSString*)value;
+(NSString*)truncateUserIdIfExceedsLimit:(NSString*)userId andLimit:(int)limit;
+(BNCProductCategory) getProductCategory:(NSString*)category;

@end

#endif /* RudderUtils_h */
