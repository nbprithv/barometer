//
//  ViewController.m
//  Barometer
//
//  Created by Niranjan Prithviraj on 7/31/14.
//  Copyright (c) 2014 Niranjan Prithviraj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) IBOutlet UITableView *tableView;
@end

@implementation ViewController {
    NSDictionary *placesList;
    NSArray *placesArr;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return placesArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    NSURL *imageURL = [NSURL URLWithString:[placesArr[indexPath.row] valueForKey:@"icon"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    [cell.imageView setImage:image];
                          
    
    
    cell.textLabel.text = [placesArr[indexPath.row] valueForKey:@"name"];
    cell.detailTextLabel.text = @"M 50%, F 50%";
    return cell;
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    //[mutableData setLength:0];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self getPlaces];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
