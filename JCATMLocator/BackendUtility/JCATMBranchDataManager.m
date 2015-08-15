//
//  JCATMBranchDataManager.m
//  JCATMLocator
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCATMBranchDataManager.h"
#import "BackendUtility.h"
#import "JCATMBranch.h"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define URL   @"https://m.chase.com/PSRWeb/location/list.action"

@interface JCATMBranchDataManager ()
{
    
}
@property (nonatomic, copy) CompletionHandler completionHandler;

@end

@implementation JCATMBranchDataManager

#pragma Mark  Lazy Instantiantion

-(CLLocationManager *)locationManager
{
    if(!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDistanceFilter:kCLDistanceFilterNone];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager setDelegate:self];
    }
    return _locationManager;
}


+ (instancetype)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceQueue;
    static JCATMBranchDataManager *sharedManager = nil;
    dispatch_once(&onceQueue, ^{
        
        if (sharedManager == nil) {
            sharedManager = [super allocWithZone:zone];
        }
    });
    
    return sharedManager;
}

+(instancetype)sharedManager
{
    
    static dispatch_once_t once = 0;
    static JCATMBranchDataManager *sharedManager;
    
    if (sharedManager) {
        return sharedManager;
    }
    
    dispatch_once(&once, ^{
        
        if (!sharedManager) {
            sharedManager = [[JCATMBranchDataManager alloc]init];
        }
    });
    
    return sharedManager;
}

#pragma Mark Public Methods

/*
 * Public method is defined to fetch current location 
 * http://stackoverflow.com/questions/26134641/how-to-get-current-location-lat-long-in-ios-8

*/
-(void)fetchCurrentLocationWithATMBranch
{
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];
}

#pragma Mark CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    if(currentLocation != nil)
    {
        [self.locationManager stopUpdatingLocation];
        // handle success case and execute only once
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self fetchNearByATMBranchWithLocation:currentLocation];

        });
    }
    else{
        // handle error case
        NSError *error = [NSError errorWithDomain:@"Some unexpected error occured" code:1 userInfo:nil];
        self.completionHandler(nil,error);
    }
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // Handle Error case
    self.completionHandler(nil, error);
}

#pragma Mark Private methods

- (void)fetchNearByATMBranchWithLocation:(CLLocation*)location
{
     NSString *urlString = [NSString stringWithFormat:@"%@?lat=%lf&lng=%lf", URL, location.coordinate.latitude, location.coordinate.longitude];
    
    __weak JCATMBranchDataManager *weakSelf = self;
    [BackendUtility requestWithURL:urlString andCompletionBlock:^(id receivedData, NSError *error) {
        NSMutableArray *dataSourceArray = [[NSMutableArray alloc] init];
        NSArray *array = (NSArray *)receivedData[@"locations"];
        for (NSDictionary *modelDict in array)
        {
            JCATMBranch *iObject = [[JCATMBranch alloc] initWithDict:modelDict];
            [dataSourceArray addObject:iObject];
        }

        weakSelf.completionHandler(dataSourceArray, error);
    }];
}

#pragma Mark Public method
-(void)fetchNearByATMBranchWithCompletionHandler:(CompletionHandler)iHandler
{
    self.completionHandler = iHandler;
    [self fetchCurrentLocationWithATMBranch];
}

@end
