//
//  GMSMapViewDelegateProxy.swift
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

public typealias GMSHandleMarkerInfo = (GMSMarker) -> (UIView?)
public typealias GMSHandleTapMyLocationButton = () -> (Bool)

class GMSMapViewDelegateProxy : DelegateProxy<GMSMapView, GMSMapViewDelegate>, DelegateProxyType, GMSMapViewDelegate {
    
    var handleTapMyLocationButton: GMSHandleTapMyLocationButton? = nil
    public var handleMarkerInfoWindow: GMSHandleMarkerInfo? = nil
    public var handleMarkerInfoContents: GMSHandleMarkerInfo? = nil
    
    let didTapMyLocationButtonEvent = PublishSubject<Void>()
    
    /// Typed parent object.
    public weak private(set) var mapView: GMSMapView?
    
    /// - parameter tabBar: Parent object for delegate proxy.
    public init(gsMapView: ParentObject) {
        self.mapView = gsMapView
        super.init(parentObject: gsMapView, delegateProxy: GMSMapViewDelegateProxy.self)
    }
    
    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { GMSMapViewDelegateProxy(gsMapView: $0) }
    }
    
    /// For more information take a look at `DelegateProxyType`.
    open class func currentDelegate(for object: ParentObject) -> GMSMapViewDelegate? {
        return object.delegate
    }
    
    /// For more information take a look at `DelegateProxyType`.
    open class func setCurrentDelegate(_ delegate: GMSMapViewDelegate?, to object: ParentObject) {
        object.delegate = delegate
    }    
}

// Referred from RxCococa.swift because it's not public
//   They said: workaround for Swift compiler bug, cheers compiler team :)

func castOptionalOrFatalError<T>(_ value: Any?) -> T? {
    if value == nil {
        return nil
    }
    let v: T = castOrFatalError(value)
    return v
}

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}

func castOrFatalError<T>(_ value: Any!) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        fatalError("Failure converting from \(value) to \(T.self)")
    }
    
    return result
}
