//
//  LocationList.h
//  Barometer
//
//  Created by Niranjan Prithviraj on 8/4/14.
//  Copyright (c) 2014 Niranjan Prithviraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import "LocationDetails.h"

@interface LocationList : UITableViewController <UIApplicationDelegate, CLLocationManagerDelegate> {
    NSString *response;
    NSString *getPlacesAPI;
    CLLocationManager *locationManager;
}

@end
