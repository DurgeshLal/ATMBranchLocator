//
//  BackendUtility.h
//  JCATMLocator
//
//  Created by Durgesh Gupta on 8/14/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef void(^receivedData)(id receivedData, NSError *error);

@interface BackendUtility : NSObject

/*
 * Class method to hit backend services.
 * Takes 2 parameter 
 * NSString:url- url to be hit
 * receivedData:compblock - A block for callback
 
 */
+ (void)requestWithURL:(NSString *)url andCompletionBlock:(receivedData)compblock;
@end
