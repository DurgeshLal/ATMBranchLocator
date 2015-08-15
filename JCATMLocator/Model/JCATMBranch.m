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
        self.access = (![dict[ACCESS] isKindOfClass:[NSNull class]] ? dict[ACCESS] : [NSNull null]);
        self.address = (![dict[ADDRESS] isKindOfClass:[NSNull class]] ? dict[ADDRESS] : [NSNull null]);
        self.bank = (![dict[BANK] isKindOfClass:[NSNull class]] ? dict[BANK] : [NSNull null]);
        self.city = (![dict[CITY] isKindOfClass:[NSNull class]] ? dict[CITY] : [NSNull null]);
        self.distance = (![dict[DISTANCE] isKindOfClass:[NSNull class]] ? dict[DISTANCE] : [NSNull null]);
        self.label = (![dict[LABEL] isKindOfClass:[NSNull class]] ? dict[LABEL] : [NSNull null]);
        self.lat = (![dict[LAT] isKindOfClass:[NSNull class]] ? dict[LAT] : [NSNull null]);
        self.lng = (![dict[LNG] isKindOfClass:[NSNull class]] ? dict[LNG] : [NSNull null]);
        self.locType = (![dict[LOC_TYPE] isKindOfClass:[NSNull class]] ? dict[LOC_TYPE] : [NSNull null]);
        self.name = (![dict[NAME] isKindOfClass:[NSNull class]] ? dict[NAME] : [NSNull null]);
        self.state = (![dict[STATE] isKindOfClass:[NSNull class]] ? dict[STATE] : [NSNull null]);
        self.zip = (![dict[ZIP] isKindOfClass:[NSNull class]] ? dict[ZIP] : [NSNull null]);
        self.phone = (![dict[PHONE] isKindOfClass:[NSNull class]] ? dict[PHONE] : [NSNull null]);
        self.languages = (![dict[LANGUAGES] isKindOfClass:[NSNull class]] ? dict[LANGUAGES] : [NSNull null]);
        self.services = (![dict[SERVICES] isKindOfClass:[NSNull class]] ? dict[SERVICES] : [NSNull null]);
        self.driveUpHrs = (![dict[DRIVE_UP_HRS] isKindOfClass:[NSNull class]] ? dict[DRIVE_UP_HRS] : [NSNull null]);
        self.lobbyHrs = (![dict[LOBBY_HRS] isKindOfClass:[NSNull class]] ? dict[LOBBY_HRS] : [NSNull null]);
        
    }
    return self;
}


@end
