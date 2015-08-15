//
//  JCATMBranch.m
//  JCATMLocator
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import "JCATMBranchAnnotation.h"

@implementation JCATMBranchAnnotation

-(id)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle withCoordinates:(CLLocationCoordinate2D)coordinate withIndex:(NSInteger)index
{
    self = [super init];
    if(self)
    {
        self.title = title;
        self.subtitle = subTitle;
        self.coordinate = coordinate;
        self.index = index;
    }
    
    return self;
}

@end
