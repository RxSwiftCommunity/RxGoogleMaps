//
//  GMSMapView+Rx.swift
//  Example
//
//  Created by Gabriel Araujo on 28/10/17.
//  Copyright © 2017 Gen X Hippies Company. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import RxSwift
import RxCocoa
import GoogleMaps

// Taken from RxCococa until marked as public
func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}

extension Reactive where Base : GMSMapView {
    
    fileprivate var delegate: GMSMapViewDelegateProxy {
        return GMSMapViewDelegateProxy.proxy(for: base)
    }
    
    public var wiilMove: ControlEvent<Bool> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:willMove:)))
            .map { a in
                return try castOrThrow(Bool.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var didChange: Observable<GMSCameraPosition> {
        return delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didChange:)))
            .map { return try castOrThrow(GMSCameraPosition.self, $0) }
    }
    
    public var idleAt: Observable<GMSCameraPosition> {
        return delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:idleAt:)))
            .map { return try castOrThrow(GMSCameraPosition.self, $0) }
    }
    
    public var didTapAt: ControlEvent<CLLocationCoordinate2D> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTapAt:)))
            .map { return try castOrThrow(CLLocationCoordinate2D.self, $0) }
        return ControlEvent(events: source)
    }
    
    public var didLongPressAt: ControlEvent<CLLocationCoordinate2D> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didLongPressAt:)))
            .map { return try castOrThrow(CLLocationCoordinate2D.self, $0) }
        return ControlEvent(events: source)
    }
    
    public var didTap: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTap:)))
            .map { return try castOrThrow(GMSMarker.self, $0) }
        return ControlEvent(events: source)
    }
    
    public var didTapInfoWindowOf: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTapInfoWindowOf:)))
            .map { return try castOrThrow(GMSMarker.self, $0) }
        return ControlEvent(events: source)
    }
    
    public var didLongPressInfoWindowOf: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didLongPressInfoWindowOf:)))
            .map { return try castOrThrow(GMSMarker.self, $0) }
        return ControlEvent(events: source)
    }
    
    public var didTapOverlay: Observable<GMSOverlay> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTap:)))
            .map { return try castOrThrow(GMSOverlay.self, $0) }
    }

    public var didTapPOI: ControlEvent<(placeID: String, name: String, location: CLLocationCoordinate2D)> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTapPOIWithPlaceID:name:location:)))
            .map {
                let placeID = try castOrThrow(NSString.self, $0[1]) as String
                let name = try castOrThrow(NSString.self, $0[2]) as String
                
                let value = try castOrThrow(NSValue.self, $0[3])
                var coordinate = CLLocationCoordinate2D()
                value.getValue(&coordinate)
                return (placeID, name, coordinate)
            }
        return ControlEvent(events: source)
    }
    
    public var markerInfoWindow: Observable<GMSMarker> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:markerInfoWindow:)))
            .map { return try castOrThrow(GMSMarker.self, $0) }
    }
    
    public var markerInfoContents: Observable<GMSMarker> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:markerInfoContents:)))
            .map { return try castOrThrow(GMSMarker.self, $0) }
    }
    
    public var didCloseInfoWindowOfMarker: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didCloseInfoWindowOf:)))
            .map { return try castOrThrow(GMSMarker.self, $0) }
        return ControlEvent(events: source)
    }
    
    public var didBeginDragging: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didBeginDragging:)))
            .map { return try castOrThrow(GMSMarker.self, $0) }
        return ControlEvent(events: source)
    }
    
    public var didEndDragging: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didEndDragging:)))
            .map { return try castOrThrow(GMSMarker.self, $0) }
        return ControlEvent(events: source)
    }
    
    public var didDrag: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didDrag:)))
            .map { return try castOrThrow(GMSMarker.self, $0) }
        return ControlEvent(events: source)
    }
    
//    - (BOOL)didTapMyLocationButtonForMapView:(GMSMapView *)mapView;
//    - (void)mapViewDidStartTileRendering:(GMSMapView *)mapView;
//    - (void)mapViewDidFinishTileRendering:(GMSMapView *)mapView;
//    - (void)mapViewSnapshotReady:(GMSMapView *)mapView;
}

