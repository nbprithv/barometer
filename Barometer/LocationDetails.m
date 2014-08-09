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
@property (weak, nonatomic) IBOutlet UILabel *LocationInfoAddress;
@property (weak, nonatomic) IBOutlet MKMapView *LocationDetailMap;

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
    //NSURL *mapUrl = [NSURL URLWithString:[imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    
    
    NSString *location = self.currentLocation.address;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         
                         
                         CLLocationCoordinate2D noLocation;
                         MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 500, 500);
                         MKCoordinateRegion region = [self.LocationDetailMap regionThatFits:viewRegion];
                         region.center = placemark.region.center;
                         region.span.longitudeDelta /= 8.0;
                         region.span.latitudeDelta /= 8.0;
                         
                         [self.LocationDetailMap setRegion:region animated:YES];
                         [self.LocationDetailMap addAnnotation:placemark];
                     }
                 }
     ];
    
    
//    [self.LocationMap setImage:image];
    self.LocationInfo.text = self.currentLocation.name;
    self.LocationInfoAddress.text = self.currentLocation.address;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
