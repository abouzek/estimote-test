//
//  BeaconTableController.m
//  estimote_test
//
//  Created by Alan Bouzek on 4/8/14.
//
//

#import "BeaconTableController.h"
#import "NotificationController.h"

@implementation BeaconTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Select Beacon";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"AllBeaconsRegion"]; // Set up a region to find all Estimote beacons
    [self.beaconManager startRangingBeaconsInRegion:self.region]; // Start looking for Estimote beacons
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region {
    self.beacons = beacons;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.beacons count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeaconCell" forIndexPath:indexPath];
    ESTBeacon *beacon = [self.beacons objectAtIndex:indexPath.row];
    UILabel *textLabel = (UILabel *)[cell viewWithTag:1];
    textLabel.text = [NSString stringWithFormat:@"%.2f", [beacon.distance floatValue]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ESTBeacon *selected = [self.beacons objectAtIndex:indexPath.row];
    NotificationController *controller = (NotificationController *) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NotificationController"];
    controller.beacon = selected;
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
