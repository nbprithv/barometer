//
//  ViewController.h
//  Barometer
//
//  Created by Niranjan Prithviraj on 7/31/14.
//  Copyright (c) 2014 Niranjan Prithviraj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "LocationList.h"

@interface ViewController : UIViewController <UITableViewDataSource, NSURLConnectionDelegate> {

    NSString *response;
    NSString *getPlacesAPI;

}

@end