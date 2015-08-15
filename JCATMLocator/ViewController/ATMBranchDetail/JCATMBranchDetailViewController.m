//
//  JCATMBranchDetailViewController.m
//  JCATMLocator
//
//  Created by Durgesh Gupta on 8/15/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import "JCATMBranchDetailViewController.h"

@interface JCATMBranchDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblBranch;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblState;
@property (weak, nonatomic) IBOutlet UILabel *lblZip;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;

@end

@implementation JCATMBranchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayDetails];
}

-(void)displayDetails{
    self.lblName.text = [NSString stringWithFormat:@"Name: %@",self.detailObject.name];
    self.lblBranch.text = [NSString stringWithFormat:@"Branch: %@",self.detailObject.bank];
    self.lblType.text = [NSString stringWithFormat:@"Type: %@",self.detailObject.locType];
    self.lblAddress.text = [NSString stringWithFormat:@"Address: %@",self.detailObject.address];
    self.lblCity.text = [NSString stringWithFormat:@"City: %@",self.detailObject.city];
    self.lblState.text = [NSString stringWithFormat:@"State: %@",self.detailObject.state];
    self.lblZip.text = [NSString stringWithFormat:@"Zip: %@",self.detailObject.zip];
    self.lblPhone.text = [NSString stringWithFormat:@"Phone: %@",self.detailObject.phone];
    self.lblDistance.text = [NSString stringWithFormat:@"Distance: %@",self.detailObject.distance];
}

@end
