//
//  BN_MapView.m
//  BN_BaseKit
//
//  Created by 许为锴 on 2016/12/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "BN_MapView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface BN_MapView()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *mapView;
    CLLocationCoordinate2D theCoordinate;
    MKPointAnnotation *pinAnnotation;
}
@end

@implementation BN_MapView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        mapView =[[MKMapView alloc]initWithFrame:self.bounds];
        mapView.zoomEnabled = YES;
        mapView.showsUserLocation = YES;
        mapView.scrollEnabled = YES;
        mapView.delegate = self;
        [self addSubview:mapView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    mapView.frame =self.bounds;
}

- (void)setLatitude:(CGFloat)latitude longitude:(CGFloat)longitude {
    
    [mapView removeAnnotation:pinAnnotation];
    //位置更新后的经纬度
    theCoordinate.latitude = latitude;
    theCoordinate.longitude = longitude;
    
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.01;
    theSpan.longitudeDelta=0.01;
    //设置地图显示的中心及范围
    MKCoordinateRegion theRegion;
    theRegion.center=theCoordinate;
    theRegion.span=theSpan;
    [mapView setRegion:theRegion];
    
    pinAnnotation = [[MKPointAnnotation alloc] init];
    pinAnnotation.coordinate = theCoordinate;
    [mapView addAnnotation:pinAnnotation];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
