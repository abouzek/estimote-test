//
//  NotificationController.m
//  estimote_test
//
//  Created by Alan Bouzek on 3/25/14.
//
//

#import "NotificationController.h"

@interface NotificationController ()

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *beaconRegion;

@end

@implementation NotificationController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID major:[self.beacon.major unsignedIntValue] minor:[self.beacon.minor unsignedIntValue] identifier:@"RegionIdentifier"];
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Enter region notification";
    NSLog(@"Entered");
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Exit region notification";
    NSLog(@"Exited");
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

@end
