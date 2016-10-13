//
//  GMSMapViewWrapper.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 10..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

@objc public protocol GMSMapViewWrapper: class {
    
    var delegateWrapper: GMSMapViewDelegateWrapper? { get set }
    
}

@objc public protocol GMSCameraPositionWrapper: class {
    
    var target: CLLocationCoordinate2D { get }
    var zoom: Float { get }
    var bearing: CLLocationDirection { get }
    var viewingAngle: Double { get }
    
}

@objc public protocol GMSMarkerWrapper: class {

    var title: String? { get set }
    var tappable: Bool { @objc(isTappable) get set }
    var zIndex: Int32 { get set }
    
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
    
    //weak var map: GMSMapViewWrapper? { get set }

    //var appearAnimation: GMSMarkerAnimation { get set }
    //var layer: GMSMarkerLayer { get }
    //weak var panoramaView: GMSPanoramaView? { get set }
    
}

@objc public protocol GMSMapViewDelegateWrapper : NSObjectProtocol {
    
    @objc optional func mapView(_ mapView: GMSMapViewWrapper, willMove gesture: Bool)

    @objc optional func mapView(_ mapView: GMSMapViewWrapper, didChangeCameraPosition position: GMSCameraPositionWrapper)

    @objc optional func mapView(_ mapView: GMSMapViewWrapper, idleAtCameraPosition position: GMSCameraPositionWrapper)

    @objc optional func mapView(_ mapView: GMSMapViewWrapper, didTapAtCoordinate coordinate: CLLocationCoordinate2D)

    @objc optional func mapView(_ mapView: GMSMapViewWrapper, didLongPressAtCoordinate coordinate: CLLocationCoordinate2D)

    @objc optional func mapView(_ mapView: GMSMapViewWrapper, didTapInfoWindowOfMarker marker: GMSMarkerWrapper)
    
    @objc optional func mapView(_ mapView: GMSMapViewWrapper, didLongPressInfoWindowOfMarker marker: GMSMarkerWrapper)

}

