//
//  NotificationController.h
//  estimote_test
//
//  Created by Alan Bouzek on 3/25/14.
//
//

#import <UIKit/UIKit.h>
#import "ESTBeaconManager.h"

@interface NotificationController : UIViewController <ESTBeaconManagerDelegate>

@property (nonatomic, strong) ESTBeacon *beacon;

@end
