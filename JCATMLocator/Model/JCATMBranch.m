//
//  JCATMBranch.m
//  JCATMLocator
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import "JCATMBranch.h"

#define ACCESS             @"access"
#define ADDRESS            @"address"
#define BANK               @"bank"
#define CITY               @"city"
#define DISTANCE           @"distance"
#define LABEL              @"label"
#define LAT                @"lat"
#define LNG                @"lng"
#define LOC_TYPE           @"locType"
#define NAME               @"name"
#define STATE              @"state"
#define ZIP                @"zip"
#define PHONE              @"phone"
#define LANGUAGES          @"languages"
#define SERVICES           @"services"
#define DRIVE_UP_HRS       @"driveUpHrs"
#define LOBBY_HRS          @"lobbyHrs"

@implementation JCATMBranch

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        self.access = (dict[ACCESS] ? dict[ACCESS] : [NSNull null]);
        self.address = (dict[ADDRESS] ? dict[ADDRESS] : [NSNull null]);
        self.bank = (dict[BANK] ? dict[BANK] : [NSNull null]);
        self.city = (dict[CITY] ? dict[CITY] : [NSNull null]);
        self.distance = (dict[DISTANCE] ? dict[DISTANCE] : [NSNull null]);
        self.label = (dict[LABEL] ? dict[LABEL] : [NSNull null]);
        self.lat = (dict[LAT] ? dict[LAT] : [NSNull null]);
        self.lng = (dict[LNG] ? dict[LNG] : [NSNull null]);
        self.locType = (dict[LOC_TYPE] ? dict[LOC_TYPE] : [NSNull null]);
        self.name = (dict[NAME] ? dict[NAME] : [NSNull null]);
        self.state = (dict[STATE] ? dict[STATE] : [NSNull null]);
        self.zip = (dict[ZIP] ? dict[ZIP] : [NSNull null]);
        self.phone = (dict[PHONE] ? dict[PHONE] : [NSNull null]);
        self.languages = (dict[LANGUAGES] ? dict[LANGUAGES] : [NSNull null]);
        self.services = (dict[SERVICES] ? dict[SERVICES] : [NSNull null]);
        self.driveUpHrs = (dict[DRIVE_UP_HRS] ? dict[DRIVE_UP_HRS] : [NSNull null]);
        self.lobbyHrs = (dict[LOBBY_HRS] ? dict[LOBBY_HRS] : [NSNull null]);
        
    }
    return self;
}


@end
