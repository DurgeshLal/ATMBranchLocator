//
//  JCATMBranch.h
//  JCATMLocator
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCATMBranch : NSObject
{
    // Variable declaration
}
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;
@property (strong, nonatomic) NSString *locType;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *access;
@property (strong, nonatomic) NSString *bank;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSString *phone;

@property (strong, nonatomic) NSArray *languages;
@property (strong, nonatomic) NSArray *services;
@property (strong, nonatomic) NSArray *driveUpHrs;
@property (strong, nonatomic) NSArray *lobbyHrs;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
