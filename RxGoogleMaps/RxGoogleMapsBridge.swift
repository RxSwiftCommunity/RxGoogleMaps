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

extension GoogleMaps.GMSMapView: GMSMapViewWrapper {
    public var delegateWrapper: GMSMapViewDelegateWrapper? {
        get { return delegate as? GMSMapViewDelegateWrapper }
        set { delegate = newValue as? GMSMapViewDelegate }
    }
}

extension GoogleMaps.GMSCameraPosition: GMSCameraPositionWrapper { }

extension GoogleMaps.GMSOverlay: GMSOverlayWrapper { }

extension GoogleMaps.GMSMarker: GMSMarkerWrapper { }
