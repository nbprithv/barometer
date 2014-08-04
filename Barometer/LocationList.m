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
}

@end

@implementation LocationList

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
    [super viewDidLoad];
    NSLog(@"asdadadsada");
    [self getPlaces];

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
    [cell.imageView setImage:image];
    
    cell.textLabel.text = [placesArr[indexPath.row] valueForKey:@"name"];
    cell.detailTextLabel.text = @"M 50%, F 50%";
    return cell;
}

- (void) getPlaces {
    getPlacesAPI = [NSString stringWithFormat:@"http://localhost:8888/places.json"];
    NSURL *urlObj = [NSURL URLWithString:getPlacesAPI];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:urlObj];
    
    //NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:urlObj];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    if (conn) {
        
    } else {
        
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    placesList = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    placesArr = [placesList valueForKey:@"results"];
    NSLog(@"array: %@",placesArr);
    NSLog(@"aray size: %i", placesArr.count);
    [self.tableView reloadData];
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

    [locationDetails setCurrentLocation:currentLoc];
}

@end
