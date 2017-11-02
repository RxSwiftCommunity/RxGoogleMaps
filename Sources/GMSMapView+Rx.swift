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

public extension Reactive where Base: GMSMapView {
    
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
    
    public var myLocationEnabled: AnyObserver<Bool> {
        return Binder(base) { control, myLocationEnabled in
            control.isMyLocationEnabled = myLocationEnabled
        }.asObserver()
    }
    
    public var myLocation: Observable<CLLocation?> {
        return observeWeakly(CLLocation.self, "myLocation")
    }
    
    public var selectedMarker: ControlProperty<GMSMarker?> {
        return ControlProperty(values: observeWeakly(GMSMarker.self, "selectedMarker"), valueSink: Binder(base) { control, selectedMarker in
                control.selectedMarker = selectedMarker
            }.asObserver()
        )
    }
    
    public var trafficEnabled: AnyObserver<Bool> {
        return Binder(base) { control, trafficEnabled in
            control.isTrafficEnabled = trafficEnabled
        }.asObserver()
    }
    
    public var padding: AnyObserver<UIEdgeInsets> {
        return Binder(base) { control, padding in
            control.padding = padding
        }.asObserver()
    }
    
    public var scrollGesturesEnabled: AnyObserver<Bool> {
        return Binder(base) { control, scrollGestures in
            control.settings.scrollGestures = scrollGestures
        }.asObserver()
    }
    
    public var zoomGesturesEnabled: AnyObserver<Bool> {
        return Binder(base) { control, zoomGestures in
            control.settings.zoomGestures = zoomGestures
        }.asObserver()
    }
    
    public var tiltGesturesEnabled: AnyObserver<Bool> {
        return Binder(base) { control, tiltGestures in
            control.settings.tiltGestures = tiltGestures
        }.asObserver()
    }
    
    public var rotateGesturesEnabled: AnyObserver<Bool> {
        return Binder(base) { control, rotateGestures in
            control.settings.rotateGestures = rotateGestures
        }.asObserver()
    }
    
    public var compassButtonVisible: AnyObserver<Bool> {
        return Binder(base) { control, compassButton in
            control.settings.compassButton = compassButton
        }.asObserver()
    }
    
    public var myLocationButtonVisible: AnyObserver<Bool> {
        return Binder(base) { control, myLocationButton in
            control.settings.myLocationButton = myLocationButton
        }.asObserver()
    }
}

extension Reactive where Base : GMSMapView {
    
    fileprivate var delegate: GMSMapViewDelegateProxy {
        return GMSMapViewDelegateProxy.proxy(for: base)
    }
    
    public func handleTapMarkerWrapper(_ closure: GMSHandleTapMarker?) {
        delegate.handleTapMarker = closure
    }
    
    public func handleTapOverlayWrapper(_ closure: @escaping GMSHandleTapOverlay) {
        delegate.handleTapOverlay = closure
    }
    
    public func handleMarkerInfoWindowWrapper(_ closure: GMSHandleMarkerInfo?) {
        delegate.handleMarkerInfoWindow = closure
    }
    
    public func handleMarkerInfoContentsWrapper(_ closure: GMSHandleMarkerInfo?) {
        delegate.handleMarkerInfoContents = closure
    }
    
    public func handleTapMyLocationButton(_ closure: GMSHandleTapMyLocationButton?) {
        delegate.handleTapMyLocationButton = closure
    }
    
    public var willMove: ControlEvent<Bool> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:willMove:)))
            .map { a in
                return try castOrThrow(Bool.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var didChange: ControlEvent<GMSCameraPosition> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didChange:)))
            .map { a in
                return try castOrThrow(GMSCameraPosition.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var idleAt: ControlEvent<GMSCameraPosition> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:idleAt:)))
            .map { a in
                return try castOrThrow(GMSCameraPosition.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var didTapAt: ControlEvent<CLLocationCoordinate2D> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTapAt:)))
            .map { a in
                return try castCoordinateOrThrow(a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var didLongPressAt: ControlEvent<CLLocationCoordinate2D> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didLongPressAt:)))
            .map { a in
                return try castCoordinateOrThrow(a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var didTap: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTap:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var didTapInfoWindowOf: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTapInfoWindowOf:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var didLongPressInfoWindowOf: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didLongPressInfoWindowOf:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
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
    
    public var didCloseInfoWindowOfMarker: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didCloseInfoWindowOf:)))
            .map { a in return try castOrThrow(GMSMarker.self, a[1]) }
        return ControlEvent(events: source)
    }
    
    public var didBeginDragging: ControlEvent<GMSMarker> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didBeginDragging:)))
            .map {  a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var didEndDragging: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didEndDragging:)))
            .map { a in return try castOrThrow(GMSMarker.self, a[1]) }
        return ControlEvent(events: source)
    }
    
    public var didDrag: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didDrag:)))
            .map { a in return try castOrThrow(GMSMarker.self, a[1]) }
        return ControlEvent(events: source)
    }
    
    public var didTapMyLocationButton: ControlEvent<Void> {
        return ControlEvent(events: delegate.didTapMyLocationButtonEvent)
    }
    
    public var didStartTileRendering: Observable<Void> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapViewDidStartTileRendering(_:)))
            .map { _ in return }
    }
    
    public var didFinishTileRendering: Observable<Void> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapViewDidFinishTileRendering(_:)))
            .map { _ in return }
    }
    
    public var snapshotReady: Observable<Void> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapViewSnapshotReady(_:)))
            .map { _ in return }
    }
    
    public func handleTapMarker(_ closure: ((GMSMarker) -> (Bool))?) {
        if let c = closure {
            handleTapMarkerWrapper { c($0) }
        } else {
            handleTapMarkerWrapper(nil)
        }
    }
    
    public func handleTapOverlay(_ closure: @escaping ((GMSOverlay) -> (Void))) {
        handleTapOverlayWrapper { closure($0) }
    }
    
    public func handleMarkerInfoWindow(_ closure: ((GMSMarker) -> (UIView?))?) {
        if let c = closure {
            handleMarkerInfoWindowWrapper { c($0) }
        } else {
            handleMarkerInfoWindowWrapper(nil)
        }
    }
    
    public func handleMarkerInfoContents(_ closure: ((GMSMarker) -> (UIView?))?) {
        if let c = closure {
            handleMarkerInfoContentsWrapper { c($0) }
        } else {
            handleMarkerInfoContentsWrapper(nil)
        }
    }
}

fileprivate func castCoordinateOrThrow(_ object: Any) throws -> CLLocationCoordinate2D {
    let value = try castOrThrow(NSValue.self, object)
    var coordinate = CLLocationCoordinate2D()
    value.getValue(&coordinate)
    return coordinate
}
