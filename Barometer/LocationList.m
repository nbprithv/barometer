//
//  LocationList.m
//  Barometer
//
//  Created by Niranjan Prithviraj on 8/4/14.
//  Copyright (c) 2014 Niranjan Prithviraj. All rights reserved.
//

#import "LocationList.h"

@interface LocationList () {
    NSMutableArray *locations;
    NSDictionary *placesList;
    NSArray *placesArr;
    UIActivityIndicatorView *indicator;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *getLocation;
@end

@implementation LocationList

- (IBAction)getLocationUpdate:(id)sender {
    [self getCurrentLoc];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    [indicator startAnimating];
    
    [super viewDidLoad];
    
    [self getCurrentLoc];
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return placesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSURL *imageURL = [NSURL URLWithString:[placesArr[indexPath.row] valueForKey:@"icon"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
//    UIImageView *cellImage = (UIImageView *)[cell.imageView viewWithTag:8];
    
    UIImageView *cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,10,75,75)];
    cellImageView.tag = 8;
    cellImageView.image = image;
    [cell addSubview:cellImageView];
    

    
    NSString *cellText = [placesArr[indexPath.row] valueForKey:@"name"];
    NSString *cellDetailText = [NSString stringWithFormat:@"%@ mi",[placesArr[indexPath.row] valueForKey:@"distance_miles"]];
    
    NSString *cellAddressText = [placesArr[indexPath.row] valueForKey:@"address"];
    
    UILabel *locationName = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *locationDistance = (UILabel *)[cell.contentView viewWithTag:12];
    UILabel *locationAddress = (UILabel *)[cell.contentView viewWithTag:14];
    [locationName setText:cellText];
    [locationDistance setText:cellDetailText];
    [locationAddress setText:cellAddressText];
    
    return cell;
}

- (void) getCurrentLoc {
    locationManager = [[CLLocationManager alloc] init];

    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locs {
    crnLoc = [locs lastObject];
    
    //Testing - Adding a alert window to show the lat, long

    
    
    
    [self getPlaces:crnLoc];

    [locationManager stopUpdatingLocation];
    [self getCurrAddress:crnLoc];
}

- (void) getPlaces:(CLLocation*)currentLoc {

    getPlacesAPI = [NSString stringWithFormat:@"http://aqueous-caverns-8294.herokuapp.com/place?action=get_places&currlat=%.8f&currlong=%.8f",currentLoc.coordinate.latitude,currentLoc.coordinate.longitude];
    NSURL *urlObj = [NSURL URLWithString:getPlacesAPI];
    
    
    NSLog(@"Longitude: %.8f Latitude %.8f",currentLoc.coordinate.latitude, currentLoc.coordinate.longitude);
    NSLog(@"%@", getPlacesAPI);
    
    [self getCurrentLoc];
    NSURLRequest *req = [NSURLRequest requestWithURL:urlObj];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    if (conn) {
        
    } else {
        
    }
}

- (void) getCurrAddress:(CLLocation*)currentLoc {
     CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLoc completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        if (error == nil && [placemarks count] > 0)
        {
            placemark = [placemarks lastObject];
            
            // strAdd -> take bydefault value nil
            NSString *strAdd = nil;
            
            if ([placemark.subThoroughfare length] != 0)
                strAdd = placemark.subThoroughfare;
            
            if ([placemark.thoroughfare length] != 0)
            {
                // strAdd -> store value of current location
                if ([strAdd length] != 0)
                    strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                else
                {
                    // strAdd -> store only this value,which is not null
                    strAdd = placemark.thoroughfare;
                }
            }
            
            if ([placemark.postalCode length] != 0)
            {
                if ([strAdd length] != 0)
                    strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                else
                    strAdd = placemark.postalCode;
            }
            
            if ([placemark.locality length] != 0)
            {
                if ([strAdd length] != 0)
                    strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                else
                    strAdd = placemark.locality;
            }
            
            if ([placemark.administrativeArea length] != 0)
            {
                if ([strAdd length] != 0)
                    strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                else
                    strAdd = placemark.administrativeArea;
            }
            
            if ([placemark.country length] != 0)
            {
                if ([strAdd length] != 0)
                    strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                else
                    strAdd = placemark.country;
            }
            NSString *alertMsg = [NSString stringWithFormat:@"Lat: %.8f Long: %.8f, Address: %@", currentLoc.coordinate.latitude, currentLoc.coordinate.longitude, strAdd];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Current Location"
                                                            message:alertMsg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    placesList = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    placesArr = [placesList valueForKey:@"results"];
    
    //NSLog(@"array: %@",placesArr);
    //NSLog(@"aray size: %i", placesArr.count);
    
    [indicator stopAnimating];
    [self.tableView reloadData];
}

- (void)startStandardUpdates
{
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 50; // meters
    
    [locationManager startUpdatingLocation];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    LocationDetails *locationDetails = [segue destinationViewController];
    
    // Pass the selected object to the new view controller.
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    Location *currentLoc = [[Location alloc] init];

    currentLoc.name = [placesArr[path.row] valueForKey:@"name"];
    currentLoc.address = [placesArr[path.row] valueForKey:@"address"];
    currentLoc.longitude = [placesArr[path.row] valueForKey:@"longitude"];
    currentLoc.latitude = [placesArr[path.row] valueForKey:@"latitude"];
    currentLoc.icon = [placesArr[path.row] valueForKey:@"icon"];
    currentLoc.userLocation = crnLoc;

    [locationDetails setCurrentLocation:currentLoc];
}

@end
