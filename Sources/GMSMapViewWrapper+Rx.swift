//
//  GMSMapViewWrapper+Rx.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 10..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import CoreLocation
import RxCocoa
import RxSwift

extension Reactive where Base: GMSMapViewWrapper {
    
    var delegateProxy: RxGMSMapViewDelegateProxy {
        return RxGMSMapViewDelegateProxy.proxyForObject(base)
    }
 
    public var delegate: RxGMSMapViewDelegate? {
        return delegateProxy.delegate
    }
    
    public func setDelegate(_ delegate: RxGMSMapViewDelegate?) {
        delegateProxy.delegate = delegate
    }
}

public extension Reactive where Base: GMSMapViewWrapper {

    public var willMove: ControlEvent<RxGMSGestureProperty> {
        let source = delegateProxy
            .methodInvoked(#selector(GMSMapViewDelegateWrapper.mapView(_:willMove:)))
            .map { a in
                return try castOrThrow(Bool.self, a[1])
            }
            .map(RxGMSGestureProperty.init)
        
        return ControlEvent(events: source)
    }
    
    public var didChange: ControlEvent<GMSCameraPositionWrapper> {
        let source = delegateProxy
            .methodInvoked(#selector(GMSMapViewDelegateWrapper.mapView(_:didChangeCameraPosition:)))
            .map { a in
                return try castOrThrow(GMSCameraPositionWrapper.self, a[1])
            }
        
        return ControlEvent(events: source)
    }
    
    public var idleAt: ControlEvent<GMSCameraPositionWrapper> {
        let source = delegateProxy
            .methodInvoked(#selector(GMSMapViewDelegateWrapper.mapView(_:idleAtCameraPosition:)))
            .map { a in
                return try castOrThrow(GMSCameraPositionWrapper.self, a[1])
        }
        
        return ControlEvent(events: source)
    }
    
    public var didTapAt: ControlEvent<CLLocationCoordinate2D> {
        let source = delegateProxy
            .methodInvoked(#selector(GMSMapViewDelegateWrapper.mapView(_:didTapAtCoordinate:)))
            .map { a in
                return try castCoordinateOrThrow(a[1])
        }
        
        return ControlEvent(events: source)
    }

    public var didLongPressAt: ControlEvent<CLLocationCoordinate2D> {
        let source = delegateProxy
            .methodInvoked(#selector(GMSMapViewDelegateWrapper.mapView(_:didLongPressAtCoordinate:)))
            .map { a in
                return try castCoordinateOrThrow(a[1])
        }
        
        return ControlEvent(events: source)
    }
    
    public var didTapMarker: ControlEvent<GMSMarkerWrapper> {
        return ControlEvent(events: delegateProxy.didTapMarker)
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
