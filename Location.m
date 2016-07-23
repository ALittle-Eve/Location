//
//  Location.m
//  MOS Weather
//
//  Created by ALittleIndie on 16/7/23.
//  Copyright © 2016年 ALittle Eve. All rights reserved.
//

#import "Location.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>


@interface Location ()<CLLocationManagerDelegate>

@property (nonatomic)CLLocationManager*locationManager;
@property (nonatomic)CLLocation *currentLocation;


@end

@implementation Location

@synthesize locationManager,currentLocation;

//开始定位
- (void)beginLocate{
    
    
    if([CLLocationManager locationServicesEnabled]) {
        
        self.locationManager = [[CLLocationManager alloc] init] ;
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManager.distanceFilter = 100;
        // 开始定位
        [locationManager startUpdatingLocation];

        
    }else {
        
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  
                                  @"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertView show];
      
        
    }
    
    
    
}

#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    
    self.currentLocation = [locations lastObject];
    
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 1.0){//如果调用已经一次，不再执行
        
        return;
        
    }else{
    
        // 获取当前所在的城市名
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
        //根据经纬度反向地理编译出地址信息
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     
         {
        
             if (array.count > 0)
            
             {
            
                 CLPlacemark *placemark = [array objectAtIndex:0];
            
            
                 //获取城市
            
                 NSString *city = placemark.locality;
            
                 if (!city) {
                
                     //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                
                     city = placemark.administrativeArea;
                
                 }
            
                 
                 //通知首页修改地址
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"updateCurrentCityNotification" object:city];
             }
        
             else
            
             {
            
                 NSLog(@"定位不到");
                 
             }
             
        }];
    
        [manager stopUpdatingLocation];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager

       didFailWithError:(NSError *)error {
    
    
    //提示用户无法进行定位操作
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              
                              @"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];

    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestAlwaysAuthorization];
            }
            break;
        default:
            break;
            
            
    }
}

@end
