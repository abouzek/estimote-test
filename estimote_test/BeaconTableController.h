//
//  BeaconTableController.h
//  estimote_test
//
//  Created by Alan Bouzek on 4/8/14.
//
//

#import <UIKit/UIKit.h>
#import "ESTBeaconManager.h"

@interface BeaconTableController : UITableViewController <ESTBeaconManagerDelegate>

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *region;
@property (nonatomic, strong) NSArray *beacons;

@end