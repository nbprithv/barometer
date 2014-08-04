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
    
    NSString *gMapsBaseURL = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?zoom=17&size=400x400&markers=color:blue|"];
    
    NSMutableString *imageURL = [NSMutableString string];
    
    [imageURL appendString:gMapsBaseURL];
    [imageURL appendString: self.currentLocation.address];
    NSURL *mapUrl = [NSURL URLWithString:[imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    
    [self.LocationMap setImage:image];
    NSLog(@"Google Maps URL %@", imageURL);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
