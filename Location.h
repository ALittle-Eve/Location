//
//  Location.h
//  MOS Weather
//
//  Created by ALittleIndie on 16/7/23.
//  Copyright © 2016年 ALittle Eve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface Location : NSObject<CLLocationManagerDelegate>

- (void)beginLocate;

@end
