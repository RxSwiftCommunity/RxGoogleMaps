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

}

extension GoogleMaps.GMSCameraPosition: RxGMSCameraPosition { }

extension GoogleMaps.GMSOverlay: RxGMSOverlay { }

extension GoogleMaps.GMSMarker: RxGMSMarker { }
