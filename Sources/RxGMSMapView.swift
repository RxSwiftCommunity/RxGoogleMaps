//
//  RxGMSMapView.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 10..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

@objc public protocol RxGMSMapView: class {
    
    var delegateWrapper: RxGMSMapViewDelegate? { get set }
    
}

@objc public protocol RxGMSCameraPosition: class {
    
    var target: CLLocationCoordinate2D { get }
    var zoom: Float { get }
    var bearing: CLLocationDirection { get }
    var viewingAngle: Double { get }
    
}

@objc public protocol RxGMSOverlay: class {
    
    var title: String? { get set }
    var tappable: Bool { @objc(isTappable) get set }
    var zIndex: Int32 { get set }
    
    //weak var map: RxGMSMapView? { get set }

}

@objc public protocol RxGMSMarker: RxGMSOverlay {
    
    var position: CLLocationCoordinate2D { get set }
    var snippet: String? { get set }
    var icon: UIImage? { get set }
    var iconView: UIView? { get set }
    var tracksViewChanges: Bool { get set }
    var tracksInfoWindowChanges: Bool { get set }
    var groundAnchor: CGPoint { get set }
    var infoWindowAnchor: CGPoint { get set }
    var draggable: Bool { @objc(isDraggable) get set }
    var flat: Bool { @objc(isFlat) get set }
    var rotation: CLLocationDegrees { get set }
    var opacity: Float { get set }
    var userData: Any? { get set }

    //var appearAnimation: GMSMarkerAnimation { get set }
    //var layer: GMSMarkerLayer { get }
    //weak var panoramaView: GMSPanoramaView? { get set }
    
}

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

    @objc optional func mapView(_ mapView: RxGMSMapView, didBeginDraggingMarker marker: RxGMSMarker)

    @objc optional func mapView(_ mapView: RxGMSMapView, didEndDraggingMarker marker: RxGMSMarker)

    @objc optional func mapView(_ mapView: RxGMSMapView, didDragMarker marker: RxGMSMarker)

    @objc optional func  mapViewDidStartTileRendering(_ mapView: RxGMSMapView)

    @objc optional func  mapViewDidFinishTileRendering(_ mapView: RxGMSMapView)
    
    @objc optional func  mapViewSnapshotReady(_ mapView: RxGMSMapView)

}

