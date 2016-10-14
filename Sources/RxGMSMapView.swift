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
    
    var cameraWrapper: RxGMSCameraPosition { get set }
    
    var myLocationEnabled: Bool { @objc(isMyLocationEnabled) get set }

    var selectedMarkerWrapper: RxGMSMarker? { get set }

    var trafficEnabled: Bool { @objc(isTrafficEnabled) get set }

    var padding: UIEdgeInsets { get set }

    var settingsWrapper: RxGMSUISettings { get }

    func animateWrapper(to cameraPosition: RxGMSCameraPosition)

    func animate(toLocation location: CLLocationCoordinate2D)

    func animate(toZoom zoom: Float)

    func animate(toBearing bearing: CLLocationDirection)

    func animate(toViewingAngle viewingAngle: Double)
    
}

@objc public protocol RxGMSUISettings: class {
    
    var scrollGestures: Bool { get set }
    var zoomGestures: Bool { get set }
    var tiltGestures: Bool { get set }
    var rotateGestures: Bool { get set }
    var compassButton: Bool { get set }
    var myLocationButton: Bool { get set }
    
}

@objc public protocol RxGMSCameraPosition: class {
    
    var target: CLLocationCoordinate2D { get }
    var zoom: Float { get }
    var bearing: CLLocationDirection { get }
    var viewingAngle: Double { get }
    
}




