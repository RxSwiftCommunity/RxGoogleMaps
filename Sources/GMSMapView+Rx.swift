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
    var camera: Binder<GMSCameraPosition> {
        return Binder(base) { control, camera in
            control.camera = camera
        }
    }
    
    var cameraToAnimate: Binder<GMSCameraPosition> {
        return Binder(base) { control, camera in
            control.animate(to: camera)
        }
    }
    
    var locationToAnimate: Binder<CLLocationCoordinate2D> {
        return Binder(base) { control, location in
            control.animate(toLocation: location)
        }
    }
    
    var zoomToAnimate: Binder<Float> {
        return Binder(base) { control, zoom in
            control.animate(toZoom: zoom)
        }
    }
    
    var bearingToAnimate: Binder<CLLocationDirection> {
        return Binder(base) { control, bearing in
            control.animate(toBearing: bearing)
        }
    }
    
    var viewingAngleToAnimate: Binder<Double> {
        return Binder(base) { control, viewingAngle in
            control.animate(toViewingAngle: viewingAngle)
        }
    }
    
    var myLocationEnabled: Binder<Bool> {
        return Binder(base) { control, myLocationEnabled in
            control.isMyLocationEnabled = myLocationEnabled
        }
    }
    
    var myLocation: Observable<CLLocation?> {
        return observeWeakly(CLLocation.self, "myLocation")
    }
    
    var selectedMarker: ControlProperty<GMSMarker?> {
        return ControlProperty(values: observeWeakly(GMSMarker.self, "selectedMarker"), valueSink: Binder(base) { control, selectedMarker in
                control.selectedMarker = selectedMarker
            }
        )
    }
    
    var trafficEnabled: Binder<Bool> {
        return Binder(base) { control, trafficEnabled in
            control.isTrafficEnabled = trafficEnabled
        }
    }
    
    var padding: Binder<UIEdgeInsets> {
        return Binder(base) { control, padding in
            control.padding = padding
        }
    }
    
    var scrollGesturesEnabled: Binder<Bool> {
        return Binder(base) { control, scrollGestures in
            control.settings.scrollGestures = scrollGestures
        }
    }
    
    var zoomGesturesEnabled: Binder<Bool> {
        return Binder(base) { control, zoomGestures in
            control.settings.zoomGestures = zoomGestures
        }
    }
    
    var tiltGesturesEnabled: Binder<Bool> {
        return Binder(base) { control, tiltGestures in
            control.settings.tiltGestures = tiltGestures
        }
    }
    
    var rotateGesturesEnabled: Binder<Bool> {
        return Binder(base) { control, rotateGestures in
            control.settings.rotateGestures = rotateGestures
        }
    }
    
    var compassButtonVisible: Binder<Bool> {
        return Binder(base) { control, compassButton in
            control.settings.compassButton = compassButton
        }
    }
    
    var myLocationButtonVisible: Binder<Bool> {
        return Binder(base) { control, myLocationButton in
            control.settings.myLocationButton = myLocationButton
        }
    }
}

public extension Reactive where Base: GMSMapView {
    fileprivate var delegate: GMSMapViewDelegateProxy {
        return GMSMapViewDelegateProxy.proxy(for: base)
    }
    
    func handleTapMarkerWrapper(_ closure: GMSHandleTapMarker?) {
        delegate.handleTapMarker = closure
    }
    
    func handleTapOverlayWrapper(_ closure: @escaping GMSHandleTapOverlay) {
        delegate.handleTapOverlay = closure
    }
    
    func handleMarkerInfoWindowWrapper(_ closure: GMSHandleMarkerInfo?) {
        delegate.handleMarkerInfoWindow = closure
    }
    
    func handleMarkerInfoContentsWrapper(_ closure: GMSHandleMarkerInfo?) {
        delegate.handleMarkerInfoContents = closure
    }
    
    func handleTapMyLocationButton(_ closure: GMSHandleTapMyLocationButton?) {
        delegate.handleTapMyLocationButton = closure
    }
    
    var willMove: ControlEvent<Bool> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:willMove:)))
            .map { a in
                return try castOrThrow(Bool.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    var didChange: ControlEvent<GMSCameraPosition> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didChange:)))
            .map { a in
                return try castOrThrow(GMSCameraPosition.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    var idleAt: ControlEvent<GMSCameraPosition> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:idleAt:)))
            .map { a in
                return try castOrThrow(GMSCameraPosition.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    var didTapAt: ControlEvent<CLLocationCoordinate2D> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTapAt:)))
            .map { a in
                return try castCoordinateOrThrow(a[1])
            }
        return ControlEvent(events: source)
    }
    
    var didLongPressAt: ControlEvent<CLLocationCoordinate2D> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didLongPressAt:)))
            .map { a in
                return try castCoordinateOrThrow(a[1])
            }
        return ControlEvent(events: source)
    }
    
    var didTap: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTap:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    var didTapInfoWindowOf: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTapInfoWindowOf:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    var didLongPressInfoWindowOf: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didLongPressInfoWindowOf:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }

    var didTapAtPoi : ControlEvent<(placeId: String, name: String, location: CLLocationCoordinate2D)> {
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
    
    var didCloseInfoWindowOfMarker: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didCloseInfoWindowOf:)))
            .map { a in return try castOrThrow(GMSMarker.self, a[1]) }
        return ControlEvent(events: source)
    }
    
    var didBeginDragging: ControlEvent<GMSMarker> {
        let source = delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didBeginDragging:)))
            .map {  a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    var didEndDragging: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didEndDragging:)))
            .map { a in return try castOrThrow(GMSMarker.self, a[1]) }
        return ControlEvent(events: source)
    }
    
    var didDrag: ControlEvent<GMSMarker> {
        let source =  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didDrag:)))
            .map { a in return try castOrThrow(GMSMarker.self, a[1]) }
        return ControlEvent(events: source)
    }
    
    var didTapMyLocationButton: ControlEvent<Void> {
        return ControlEvent(events: delegate.didTapMyLocationButtonEvent)
    }
    
    var didStartTileRendering: Observable<Void> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapViewDidStartTileRendering(_:)))
            .map { _ in return }
    }
    
    var didFinishTileRendering: Observable<Void> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapViewDidFinishTileRendering(_:)))
            .map { _ in return }
    }
    
    var snapshotReady: Observable<Void> {
        return  delegate
            .methodInvoked(#selector(GMSMapViewDelegate.mapViewSnapshotReady(_:)))
            .map { _ in return }
    }
    
    func handleTapMarker(_ closure: ((GMSMarker) -> (Bool))?) {
        if let c = closure {
            handleTapMarkerWrapper { c($0) }
        } else {
            handleTapMarkerWrapper(nil)
        }
    }
    
    func handleTapOverlay(_ closure: @escaping ((GMSOverlay) -> (Void))) {
        handleTapOverlayWrapper { closure($0) }
    }
    
    func handleMarkerInfoWindow(_ closure: ((GMSMarker) -> (UIView?))?) {
        if let c = closure {
            handleMarkerInfoWindowWrapper { c($0) }
        } else {
            handleMarkerInfoWindowWrapper(nil)
        }
    }
    
    func handleMarkerInfoContents(_ closure: ((GMSMarker) -> (UIView?))?) {
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
