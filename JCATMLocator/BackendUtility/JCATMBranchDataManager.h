//
//  JCATMBranchDataManager.h
//  JCATMLocator
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^CompletionHandler)(id responseData, NSError *error);

@interface JCATMBranchDataManager : NSObject<CLLocationManagerDelegate>

{
    // Declare any public variable here
}

@property (nonatomic, strong) CLLocationManager *locationManager;

/*
 * Singleton Method.
 
 */
+(instancetype)sharedManager;

/*
 * Class method to near by ATM & branch.
 * Takes 1 parameter
 * CompletionHandler:iHandler - A block for callback
 
 */
-(void)fetchNearByATMBranchWithCompletionHandler:(CompletionHandler)iHandler;

@end
