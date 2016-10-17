//
//  RxGMSMapViewDelegate.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 14..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

@objc public protocol RxGMSMapViewDelegate : NSObjectProtocol {
    
    @objc optional func mapView(_ mapView: RxGMSMapView, willMove gesture: Bool)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didChangeCameraPosition position: RxGMSCameraPosition)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, idleAtCameraPosition position: RxGMSCameraPosition)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didTapInfoWindowOfMarker marker: RxGMSMarker)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didLongPressInfoWindowOfMarker marker: RxGMSMarker)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didTapOverlay overlay: RxGMSOverlay)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didTapPOIWithPlaceID placeID: NSString, name: NSString, location: CLLocationCoordinate2D)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didCloseInfoWindowOfMarker marker: RxGMSMarker)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didBeginDraggingMarker marker: RxGMSMarker)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didEndDraggingMarker marker: RxGMSMarker)
    
    @objc optional func mapView(_ mapView: RxGMSMapView, didDragMarker marker: RxGMSMarker)
    
    @objc optional func  mapViewDidStartTileRendering(_ mapView: RxGMSMapView)
    
    @objc optional func  mapViewDidFinishTileRendering(_ mapView: RxGMSMapView)
    
    @objc optional func  mapViewSnapshotReady(_ mapView: RxGMSMapView)
    
}
