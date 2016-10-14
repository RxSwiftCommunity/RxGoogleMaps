//
//  RxGoogleMapsBridge.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 11..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import GoogleMaps
import RxGoogleMaps
import RxCocoa
import RxSwift

extension RxGMSMapViewDelegateProxy: GMSMapViewDelegate {

    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return self.didHandleTap(marker)
    }

    public func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return self.markerInfoWindow(marker: marker)
    }
    
    public func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        return self.markerInfoContents(marker: marker)
    }
    
    public func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return self.didTapMyLocationButton()
    }
}

extension GoogleMaps.GMSMapView: RxGMSMapView {
    public var delegateWrapper: RxGMSMapViewDelegate? {
        get { return delegate as? RxGMSMapViewDelegate }
        set { delegate = newValue as? GMSMapViewDelegate }
    }
    
    public var cameraWrapper: RxGMSCameraPosition {
        get { return camera as RxGMSCameraPosition }
        set { camera = newValue as! GMSCameraPosition }
    }
    
    public var selectedMarkerWrapper: RxGMSMarker? {
        get { return selectedMarker as? RxGMSMarker }
        set { selectedMarker = newValue as? GMSMarker }
    }

    public func animateWrapper(to cameraPosition: RxGMSCameraPosition) {
        animate(to: cameraPosition as! GMSCameraPosition)
    }

    public var settingsWrapper: RxGMSUISettings {
        return settings as RxGMSUISettings
    }
    
}

extension Reactive where Base: GoogleMaps.GMSMapView {
    
    public var didChange: ControlEvent<GMSCameraPosition> {
        return ControlEvent(events: didChangeWrapper.map { $0 as! GMSCameraPosition })
    }
    
    public var idleAt: ControlEvent<GMSCameraPosition> {
        return ControlEvent(events: idleAtWrapper.map { $0 as! GMSCameraPosition })
    }
    
    public var didTapMarker: ControlEvent<GMSMarker> {
        return ControlEvent(events: didTapMarkerWrapper.map { $0 as! GMSMarker })
    }
    
    public var didTapInfoWindow: ControlEvent<GMSMarker> {
        return ControlEvent(events: didTapInfoWindowWrapper.map { $0 as! GMSMarker })
    }
    
    public var didLongPressInfoWindow: ControlEvent<GMSMarker> {
        return ControlEvent(events: didLongPressInfoWindowWrapper.map { $0 as! GMSMarker })
    }
    
    public var didTapOverlay: ControlEvent<GMSOverlay> {
        return ControlEvent(events: didTapOverlayWrapper.map { $0 as! GMSOverlay })
    }
    
    public var didBeginDraggingMarker: ControlEvent<GMSMarker> {
        return ControlEvent(events: didBeginDraggingMarkerWrapper.map { $0 as! GMSMarker })
    }
    
    public var didEndDraggingMarker: ControlEvent<GMSMarker> {
        return ControlEvent(events: didEndDraggingMarkerWrapper.map { $0 as! GMSMarker })
    }
    
    public var didDragMarker: ControlEvent<GMSMarker> {
        return ControlEvent(events: didDragMarkerWrapper.map { $0 as! GMSMarker })
    }
    
}

extension Reactive where Base: GoogleMaps.GMSMapView {

    public func handleTapMarker(_ closure: ((GMSMarker) -> (Bool))?) {
        if let c = closure {
            handleTapMarkerWrapper { c($0 as! GMSMarker) }
        } else {
            handleTapMarkerWrapper(nil)
        }
    }
    
    public func handleMarkerInfoWindow(_ closure: ((GMSMarker) -> (UIView?))?) {
        if let c = closure {
            handleMarkerInfoWindowWrapper { c($0 as! GMSMarker) }
        } else {
            handleMarkerInfoWindowWrapper(nil)
        }
    }
    
    public func handleMarkerInfoContents(_ closure: ((GMSMarker) -> (UIView?))?) {
        if let c = closure {
            handleMarkerInfoContentsWrapper { c($0 as! GMSMarker) }
        } else {
            handleMarkerInfoContentsWrapper(nil)
        }
    }

}

extension GoogleMaps.GMSUISettings: RxGMSUISettings { }

extension GoogleMaps.GMSCameraPosition: RxGMSCameraPosition { }

extension GoogleMaps.GMSOverlay: RxGMSOverlay { }

extension GoogleMaps.GMSMarker: RxGMSMarker { }
