//
//  ViewController.m
//  Location Test
//
//  Created by Robert Ryan on 12/4/12.
//
//  Copyright (c) 2012 Robert M. Ryan
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

#warning replace this URL with the URL of your server-based JSON results
#define kLocationsUrlString @"http://your-url-goes-here.com/locations.json"

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self startStandardUpdates];
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == self.locationManager)
       self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 500;
    
    [self.locationManager startUpdatingLocation];
}

// Once location services have successfully started (i.e., didUpdateLocations is operating)
// you can call this to:
//
//   (a) retrieve the locations from the server; and
//   (b) compare to the current location
//
// You'll have to decide whether you want to call this every minute, or
// just when didUpdateLocations changes.

- (void)checkLocation
{
    NSURL *url = [NSURL URLWithString:kLocationsUrlString];
    NSData *locationsData = [NSData dataWithContentsOfURL:url];
    NSAssert(locationsData, @"failure to download data"); // replace this with graceful error handling
    
    NSError *error;
    NSArray *locationsArray = [NSJSONSerialization JSONObjectWithData:locationsData
                                                              options:0
                                                                error:&error];
    NSAssert(locationsArray, @"failure to parse JSON");   // replace with with graceful error handling
    
    for (NSDictionary *locationEntry in locationsArray)
    {
        NSNumber *longitude = locationEntry[@"longitude"];
        NSNumber *latitude = locationEntry[@"latitude"];
        NSString *locationName = locationEntry[@"name"];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue]
                                                          longitude:[longitude doubleValue]];
        NSAssert(location, @"failure to create location");
        
        CLLocationDistance distance = [location distanceFromLocation:self.locationManager.location];
        
        if (distance <= 300)
        {
            NSLog(@"You are within 300 meters (actually %.0f meters) of %@", distance, locationName);
        }
        else
        {
            NSLog(@"You are not within 300 meters (actually %.0f meters) of %@", distance, locationName);
        }
    }
}

#pragma mark - the CLLocationManagerDelegate Methods

// this is used in iOS 6 and later

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self checkLocation];
}

// this is used in iOS 5 and earlier

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0)
        [self checkLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s error = %@", __FUNCTION__, error);
}


@end
