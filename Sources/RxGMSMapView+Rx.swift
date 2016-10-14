//
//  RxGMSMapView+Rx.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 10..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import CoreLocation
import RxCocoa
import RxSwift

extension Reactive where Base: RxGMSMapView {
    
    var delegateProxy: RxGMSMapViewDelegateProxy {
        return RxGMSMapViewDelegateProxy.proxyForObject(base)
    }
 
    public func handleTapMarker(_ closure: RxGMSHandleTapMarker?) {
        delegateProxy.handleTapMarker = closure
    }
    
    public func handleMarkerInfoWindow(_ closure: RxGMSHandleMarkerInfoView?) {
        delegateProxy.handleMarkerInfoWindow = closure
    }
    
    public func handleMarkerInfoContents(_ closure: RxGMSHandleMarkerInfoView?) {
        delegateProxy.handleMarkerInfoContents = closure
    }

    public func handleTapMyLocationButton(_ closure: RxGMSHandleTapMyLocationButton?) {
        delegateProxy.handleTapMyLocationButton = closure
    }
}

public extension Reactive where Base: RxGMSMapView {

    public var willMove: ControlEvent<RxGMSGestureProperty> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:willMove:)))
            .map { a in
                return try castOrThrow(Bool.self, a[1])
            }
            .map(RxGMSGestureProperty.init)
        
        return ControlEvent(events: source)
    }
    
    public var didChange: ControlEvent<RxGMSCameraPosition> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:didChangeCameraPosition:)))
            .map { a in
                return try castOrThrow(RxGMSCameraPosition.self, a[1])
            }
        
        return ControlEvent(events: source)
    }
    
    public var idleAt: ControlEvent<RxGMSCameraPosition> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:idleAtCameraPosition:)))
            .map { a in
                return try castOrThrow(RxGMSCameraPosition.self, a[1])
        }
        
        return ControlEvent(events: source)
    }
    
    public var didTapAt: ControlEvent<CLLocationCoordinate2D> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:didTapAtCoordinate:)))
            .map { a in
                return try castCoordinateOrThrow(a[1])
        }
        
        return ControlEvent(events: source)
    }

    public var didLongPressAt: ControlEvent<CLLocationCoordinate2D> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:didLongPressAtCoordinate:)))
            .map { a in
                return try castCoordinateOrThrow(a[1])
        }
        
        return ControlEvent(events: source)
    }
    
    public var didTapMarker: ControlEvent<RxGMSMarker> {
        return ControlEvent(events: delegateProxy.didTapMarkerEvent)
    }
    
    public var didTapInfoWindow: ControlEvent<RxGMSMarker> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:didTapInfoWindowOfMarker:)))
            .map { a in
                return try castOrThrow(RxGMSMarker.self, a[1])
        }
        
        return ControlEvent(events: source)
    }
    
    public var didLongPressInfoWindow: ControlEvent<RxGMSMarker> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:didLongPressInfoWindowOfMarker:)))
            .map { a in
                return try castOrThrow(RxGMSMarker.self, a[1])
        }
        
        return ControlEvent(events: source)
    }
    
    public var didTapOverlay: ControlEvent<RxGMSOverlay> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:didTapOverlay:)))
            .map { a in
                return try castOrThrow(RxGMSOverlay.self, a[1])
        }
        
        return ControlEvent(events: source)
    }

    public var didTapPOI: ControlEvent<(placeID: String, name: String, location: CLLocationCoordinate2D)> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:didTapPOIWithPlaceID:name:location:)))
            .map { a -> (placeID: String, name: String, location: CLLocationCoordinate2D)in
                let placeID = try castOrThrow(NSString.self, a[1]) as String
                let name = try castOrThrow(NSString.self, a[2]) as String
                
                let value = try castOrThrow(NSValue.self, a[3])
                var coordinate = CLLocationCoordinate2D()
                value.getValue(&coordinate)
                return (placeID, name, coordinate)
        }

        return ControlEvent(events: source)
    }

    public var didTapMyLocationButton: ControlEvent<Void> {
        return ControlEvent(events: delegateProxy.didTapMyLocationButtonEvent)
    }

}

public struct RxGMSGestureProperty {
    public let byGesture: Bool
}

func castCoordinateOrThrow(_ object: Any) throws -> CLLocationCoordinate2D {
    let value = try castOrThrow(NSValue.self, object)
    var coordinate = CLLocationCoordinate2D()
    value.getValue(&coordinate)
    return coordinate
}