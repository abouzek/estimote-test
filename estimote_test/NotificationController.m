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
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *clockInDistanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *clockStatusLabel;
@property (strong, nonatomic) IBOutlet UIButton *clockButton;
@property NSNumber *distance, *clockInDistance;

@end

@implementation NotificationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clockInDistance = [NSNumber numberWithDouble:.5];
    self.clockInDistanceLabel.text = @".5";
    self.clockStatusLabel.text = @"Clocked Out";
    
    self.distanceLabel.text = @"Out of Range";
    
    self.clockButton.hidden = YES;
    self.clockButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.clockButton setTitle:@"Clock In" forState:UIControlStateNormal];
    
	self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID major:[self.beacon.major unsignedIntValue] minor:[self.beacon.minor unsignedIntValue] identifier:@"RegionIdentifier"];
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider*)sender;
    self.clockInDistanceLabel.text = [NSString stringWithFormat:@"%.2f", slider.value];
    self.clockInDistance = [NSNumber numberWithFloat:slider.value];
}

- (IBAction)clockButtonPressed:(id)sender {
    if ([self.clockStatusLabel.text isEqualToString:@"Clocked In"]) {
        self.clockStatusLabel.text = @"Clocked Out";
        [self.clockButton setTitle:@"Clock In" forState:UIControlStateNormal];
    }
    else {
        self.clockStatusLabel.text = @"Clocked In";
        [self.clockButton setTitle:@"Clock Out" forState:UIControlStateNormal];
    }
}

#pragma mark - ESTBeaconManager delegate

// Code only necessary for region enter/exit notification trigger

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region {
    ESTBeacon *beacon = [beacons objectAtIndex:0];
    self.distance = [beacon distance];
    if ([self.distance intValue] == -1)
        self.distanceLabel.text = @"Out of Range";
    else
        self.distanceLabel.text = [NSString stringWithFormat: @"%.2f", [[beacon distance] doubleValue]];
    
    if ([self.distance intValue] != -1 && [self.distance doubleValue] <= [self.clockInDistance doubleValue])
        self.clockButton.hidden = NO;
    else
        self.clockButton.hidden = YES;
}

//- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
//{
//    UILocalNotification *notification = [UILocalNotification new];
//    notification.alertBody = @"Enter region notification";
//    NSLog(@"Entered");
//    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
//    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
//}
//
//- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
//{
//    UILocalNotification *notification = [UILocalNotification new];
//    notification.alertBody = @"Exit region notification";
//    NSLog(@"Exited");
//    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
//    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
//    self.distance = [NSNumber numberWithInt:9999];
//    self.distanceLabel.text = @"Out of range";
//}

@end
