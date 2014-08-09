//
//  AppDelegate.h
//  Barometer
//
//  Created by Niranjan Prithviraj on 7/31/14.
//  Copyright (c) 2014 Niranjan Prithviraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocation *locationManager;

@end
