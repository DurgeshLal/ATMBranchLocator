//
//  JCATMBranchViewController.m
//  JCATMLocator
//
//  Created by Durgesh Gupta on 8/14/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//
#import "JCATMBranchDetailViewController.h"
#import "JCATMBranchViewController.h"
#import "JCATMBranchDataManager.h"
#import "JCATMBranchAnnotation.h"
#import "JCATMBranch.h"
#import <MapKit/MapKit.h>


@interface JCATMBranchViewController (){
    NSArray *dataSourceArray;
}
// IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *lblNotification;
@property (weak, nonatomic) IBOutlet MKMapView *mapATMBranch;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation JCATMBranchViewController

-(void)internalSetUP
{
    [self hideMap];
}

-(void)awakeFromNib
{
    [self internalSetUP];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self FetchNearByATMBranch];
}

/*
 * Network call to fetch near by ATM & Branch
 * Call back give either response data or proper error
 */
-(void)FetchNearByATMBranch{
    
    __weak JCATMBranchViewController *weakSelf = self;
    [[JCATMBranchDataManager sharedManager] fetchNearByATMBranchWithCompletionHandler:^(id responseData, NSError *error) {
        if (responseData) {
            // Is success? Display annotation on map
            dataSourceArray = (NSArray *)responseData;
            dispatch_sync(dispatch_get_main_queue(), ^{
                [weakSelf successWithData:dataSourceArray];
            });
        }
        else{
            // Is Error? Display proper error msg
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf errorWithError:error];
            });
            
        }
    }];

}

#pragma Mark Private Methods


-(void)successWithData:(NSArray *)array
{
    [self showMap];
    NSInteger index = 0;
    
    for (JCATMBranch *iObject in array)
    {
        [self addATMBranchMapAnnotation:[iObject locType] subTitle:iObject.address withLatitude:[iObject lat] withLongitude:[iObject lng] withIndex:index++];
    }

}
-(void)addATMBranchMapAnnotation:(NSString *)title
                        subTitle:(NSString *)subTitle
                    withLatitude:(NSString*)latitude
                   withLongitude:(NSString*)longitude
                         withIndex:(NSInteger)Index
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [latitude doubleValue];
    coordinate.longitude = [longitude doubleValue];
    
    JCATMBranchAnnotation *newAnnotation = [[JCATMBranchAnnotation alloc] initWithTitle:title subTitle:subTitle  withCoordinates:coordinate withIndex:Index];
    [self.mapATMBranch addAnnotation:newAnnotation];
}

-(void)errorWithError:(NSError *)error
{
    
    __weak JCATMBranchViewController *weakSelf = self;
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Simulator Specific Error:1.For testing go to Edit Scheme--> Option--> Set Default Location 1. GOTO simulator debug--> Location --> Apple"
                                  message:[error localizedDescription]
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* retry = [UIAlertAction
                             actionWithTitle:@"Retray"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [weakSelf FetchNearByATMBranch];
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:retry];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)hideMap{
    [self.lblNotification setHidden:NO];
    [self.mapATMBranch setHidden:YES];
    [self.activityIndicator startAnimating];
    [self.activityIndicator setHidden:NO];
}
-(void)showMap{
    [self.lblNotification setHidden:YES];
    [self.mapATMBranch setHidden:NO];
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
}

#pragma Mark MKAnnotationDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *reuseID = @"reuseID";
    
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseID];
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    JCATMBranchAnnotation *atmbranchAnn = (JCATMBranchAnnotation *)annotation;
    [annotationView setTag:[atmbranchAnn index]];

    return annotationView;
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id<MKAnnotation> mp = [annotationView annotation];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1500, 1500);
    [mapView setRegion:region animated:YES];
    [mapView selectAnnotation:mp animated:YES];
}



-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    int index = [view tag];
    
    JCATMBranch *iObject = (JCATMBranch *)dataSourceArray[index];
    JCATMBranchDetailViewController *aController = [self.storyboard instantiateViewControllerWithIdentifier:@"JCATMBranchDetailViewController"];
    aController.detailObject = iObject;
    [self.navigationController pushViewController:aController animated:YES];

}

#pragma mark - Action sheet

- (IBAction)onFilerClicked:(id)sender
{
    UIActionSheet *filterOptionActionSheet = [[UIActionSheet alloc] initWithTitle:@"Location Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"ATMs", @"Branches", @"All", nil];
    
    [filterOptionActionSheet showFromBarButtonItem:sender animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [actionSheet cancelButtonIndex])
    {
        return;
    }
    
    if(buttonIndex == 0)
    {
        NSPredicate *atmPredicate = [NSPredicate predicateWithFormat:@"locType == \"atm\""];
        NSArray *atmArray = [dataSourceArray filteredArrayUsingPredicate:atmPredicate];
        
        [self successWithData:atmArray];
        return;
    }
    
    if(buttonIndex == 1)
    {
        NSPredicate *branchPredicate = [NSPredicate predicateWithFormat:@"locType == \"branch\""];
        NSArray *branchArray = [dataSourceArray filteredArrayUsingPredicate:branchPredicate];
        
        [self successWithData:branchArray];
        return;
    }
    
    if(buttonIndex == 2)
    {
        [self successWithData:dataSourceArray];
        return;
    }
}


@end
