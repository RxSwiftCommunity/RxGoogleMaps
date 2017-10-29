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

public extension Reactive where Base: GMSMapView, Base: UIView {
    
    public var camera: AnyObserver<GMSCameraPosition> {
        return Binder(base) { control, camera in
            control.camera = camera
            }.asObserver()
    }
    
    public var cameraToAnimate: AnyObserver<GMSCameraPosition> {
        return Binder(base) { control, camera in
            control.animate(to: camera)
            }.asObserver()
    }
    
    public var locationToAnimate: AnyObserver<CLLocationCoordinate2D> {
        return Binder(base) { control, location in
            control.animate(toLocation: location)
            }.asObserver()
    }
    
    public var zoomToAnimate: AnyObserver<Float> {
        return Binder(base) { control, zoom in
            control.animate(toZoom: zoom)
            }.asObserver()
    }
    
    public var bearingToAnimate: AnyObserver<CLLocationDirection> {
        return Binder(base) { control, bearing in
            control.animate(toBearing: bearing)
            }.asObserver()
    }
    
    public var viewingAngleToAnimate: AnyObserver<Double> {
        return Binder(base) { control, viewingAngle in
            control.animate(toViewingAngle: viewingAngle)
            }.asObserver()
    }
    
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

    public var didTapAtPoi : ControlEvent<(placeId: String, name: String, location: CLLocationCoordinate2D)> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTapPOIWithPlaceID:name:location:)))
            .map { a -> (placeId: String, name: String, location: CLLocationCoordinate2D) in
                let placeId = try castOrThrow(NSString.self, a[1]) as String
                let name = try castOrThrow(NSString.self, a[2]) as String
                let value = try castOrThrow(NSValue.self, a[3])
                var coordinate = CLLocationCoordinate2D()
                value.getValue(&coordinate)
                return (placeId, name, coordinate)
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
    
    public var didTapMyLocationButton: ControlEvent<Bool> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.didTapMyLocationButton(for:)))
            .map { return try castOrThrow(Bool.self, $0) }
        return ControlEvent(events: source)
    }
    
    public var mapViewDidStartTileRendering: Observable<Void> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapViewDidStartTileRendering(_:)))
            .map { return try castOrThrow(Void.self, $0) }
    }
    
    public var mapViewDidFinishTileRendering: Observable<Void> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapViewDidFinishTileRendering(_:)))
            .map { return try castOrThrow(Void.self, $0) }
    }
    
    public var mapViewSnapshotReady: Observable<Void> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapViewSnapshotReady(_:)))
            .map { return try castOrThrow(Void.self, $0) }
    }
}

