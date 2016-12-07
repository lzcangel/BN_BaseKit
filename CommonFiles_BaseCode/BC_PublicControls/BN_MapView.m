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

-(void)layoutSubviews {
    [super layoutSubviews];
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView.frame =self.bounds;
    });
}

- (void)layoutIfNeeded
{
    [super layoutIfNeeded];
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView.frame =self.bounds;
    });
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    mapView.frame =self.bounds;
}

- (void)andAnnotationLatitude:(CGFloat)latitude longitude:(CGFloat)longitude {
    
    CLLocationCoordinate2D theCoordinate;
    //位置更新后的经纬度
    theCoordinate.latitude = latitude;
    theCoordinate.longitude = longitude;
    
    MKPointAnnotation *pinAnnotation = [[MKPointAnnotation alloc] init];
    pinAnnotation.coordinate = theCoordinate;
    [mapView addAnnotation:pinAnnotation];
}

- (void)setDelta:(CGFloat)Delta Latitude:(CGFloat)latitude longitude:(CGFloat)longitude
{
    CLLocationCoordinate2D theCoordinate;
    //位置更新后的经纬度
    theCoordinate.latitude = latitude;
    theCoordinate.longitude = longitude;
    
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=Delta;
    theSpan.longitudeDelta=Delta;
    //设置地图显示的中心及范围
    MKCoordinateRegion theRegion;
    theRegion.center=theCoordinate;
    theRegion.span=theSpan;
    [mapView setRegion:theRegion];
}

- (void)removeAllAnnotation
{
    [mapView.annotations enumerateObjectsUsingBlock:^(id<MKAnnotation>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mapView removeAnnotation:obj];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
