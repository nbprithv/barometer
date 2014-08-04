//
//  LocationDetails.m
//  Barometer
//
//  Created by Niranjan Prithviraj on 8/4/14.
//  Copyright (c) 2014 Niranjan Prithviraj. All rights reserved.
//

#import "LocationDetails.h"

@interface LocationDetails ()
@property (weak, nonatomic) IBOutlet UILabel *LocationInfo;
@property (weak, nonatomic) IBOutlet UIImageView *LocationMap;

@end

@implementation LocationDetails

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
