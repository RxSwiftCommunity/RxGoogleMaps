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
        return self.mapView(mapView, didHandleTap: marker)
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
