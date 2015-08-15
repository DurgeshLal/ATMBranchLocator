//
//  JCATMBranch.h
//  JCATMLocator
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface JCATMBranchAnnotation : NSObject<MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) NSInteger index;

-(id)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle withCoordinates:(CLLocationCoordinate2D)coordinate withIndex:(NSInteger)index;

@end
