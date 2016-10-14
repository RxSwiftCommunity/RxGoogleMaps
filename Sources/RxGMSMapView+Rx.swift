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
    
    fileprivate var delegateProxy: RxGMSMapViewDelegateProxy {
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

// GMSMapView delegate

public extension Reactive where Base: RxGMSMapView {

    private func methodInvokedWithParam1<T>(_ selector: Selector) -> Observable<T> {
        return delegateProxy
            .methodInvoked(selector)
            .map { a in return try castOrThrow(T.self, a[1]) }
    }
    
    private func controlEventWithParam1<T>(_ selector: Selector) -> ControlEvent<T> {
        return ControlEvent(events: methodInvokedWithParam1(selector))
    }
    
    public var willMove: ControlEvent<RxGMSGestureProperty> {
        return ControlEvent(events:
            methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:willMove:)))
                .map(RxGMSGestureProperty.init)
        )
    }
    
    public var didChange: ControlEvent<RxGMSCameraPosition> {
        return controlEventWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didChangeCameraPosition:)))
    }
    
    public var idleAt: ControlEvent<RxGMSCameraPosition> {
        return controlEventWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:idleAtCameraPosition:)))
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
        return controlEventWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didTapInfoWindowOfMarker:)))
    }
    
    public var didLongPressInfoWindow: ControlEvent<RxGMSMarker> {
        return controlEventWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didLongPressInfoWindowOfMarker:)))
    }
    
    public var didTapOverlay: ControlEvent<RxGMSOverlay> {
        return controlEventWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didTapOverlay:)))
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

    public var didBeginDraggingMarker: ControlEvent<RxGMSMarker> {
        return controlEventWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didBeginDraggingMarker:)))
    }

    public var didEndDraggingMarker: ControlEvent<RxGMSMarker> {
        return controlEventWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didEndDraggingMarker:)))
    }

    public var didDragMarker: ControlEvent<RxGMSMarker> {
        return controlEventWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didDragMarker:)))
    }

    public var didStartTileRendering: ControlEvent<Void> {
        return ControlEvent(events:
            delegateProxy
                .methodInvoked(#selector(RxGMSMapViewDelegate.mapViewDidStartTileRendering(_:)))
                .map{ _ in return }
        )
    }
    
    public var didFinishTileRendering: ControlEvent<Void> {
        return ControlEvent(events:
            delegateProxy
                .methodInvoked(#selector(RxGMSMapViewDelegate.mapViewDidFinishTileRendering(_:)))
                .map{ _ in return }
        )
    }
    
    public var snapshotReady: ControlEvent<Void> {
        return ControlEvent(events:
            delegateProxy
                .methodInvoked(#selector(RxGMSMapViewDelegate.mapViewSnapshotReady(_:)))
                .map{ _ in return }
        )
    }
}

// GMSMapView properties

public extension Reactive where Base: RxGMSMapView, Base: UIView {
    
    public var camera: AnyObserver<RxGMSCameraPosition> {
        return UIBindingObserver(UIElement: base) { control, camera in
            control.cameraWrapper = camera
        }.asObserver()
    }
    
    public var cameraToAnimate: AnyObserver<RxGMSCameraPosition> {
        return UIBindingObserver(UIElement: base) { control, camera in
            control.animateWrapper(to: camera)
        }.asObserver()
    }
    
    public var locationToAnimate: AnyObserver<CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: base) { control, location in
            control.animate(toLocation: location)
        }.asObserver()
    }
    
    public var zoomToAnimate: AnyObserver<Float> {
        return UIBindingObserver(UIElement: base) { control, zoom in
            control.animate(toZoom: zoom)
        }.asObserver()
    }
    
    public var bearingToAnimate: AnyObserver<CLLocationDirection> {
        return UIBindingObserver(UIElement: base) { control, bearing in
            control.animate(toBearing: bearing)
        }.asObserver()
    }
    
    public var viewingAngleToAnimate: AnyObserver<Double> {
        return UIBindingObserver(UIElement: base) { control, viewingAngle in
            control.animate(toViewingAngle: viewingAngle)
        }.asObserver()
    }
    
    public var myLocationEnabled: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, myLocationEnabled in
            control.myLocationEnabled = myLocationEnabled
        }.asObserver()
    }

    public var myLocation: Observable<CLLocation?> {
        return observeWeakly(CLLocation.self, "myLocation")
    }
    
    public var selectedMarker: ControlProperty<RxGMSMarker?> {
        return ControlProperty(values: observeWeakly(RxGMSMarker.self, "selectedMarker"),
                               valueSink: UIBindingObserver(UIElement: base) { control, selectedMarker in
                                       control.selectedMarkerWrapper = selectedMarker
                                   }.asObserver()
        )
    }
    
    public var trafficEnabled: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, trafficEnabled in
            control.trafficEnabled = trafficEnabled
        }.asObserver()
    }
}

// 

public struct RxGMSGestureProperty {
    public let byGesture: Bool
}

fileprivate func castCoordinateOrThrow(_ object: Any) throws -> CLLocationCoordinate2D {
    let value = try castOrThrow(NSValue.self, object)
    var coordinate = CLLocationCoordinate2D()
    value.getValue(&coordinate)
    return coordinate
}
