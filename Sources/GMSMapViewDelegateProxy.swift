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

public typealias GMSHandleTapMarker = (GMSMarker) -> (Bool)
public typealias GMSHandleTapOverlay = (GMSOverlay) -> (Void)
public typealias GMSHandleMarkerInfo = (GMSMarker) -> (UIView?)
public typealias GMSHandleTapMyLocationButton = () -> (Bool)

class GMSMapViewDelegateProxy : DelegateProxy<GMSMapView, GMSMapViewDelegate>, DelegateProxyType, GMSMapViewDelegate {
    
    var handleTapMarker: GMSHandleTapMarker? = nil
    var handleTapOverlay: GMSHandleTapOverlay? = nil
    var handleTapMyLocationButton: GMSHandleTapMyLocationButton? = nil
    var handleMarkerInfoWindow: GMSHandleMarkerInfo? = nil
    var handleMarkerInfoContents: GMSHandleMarkerInfo? = nil
    
    let didTapMyLocationButtonEvent = PublishSubject<Void>()
    let didTapMarkerEvent = PublishSubject<GMSMarker>()
    let didTapOverlayEvent = PublishSubject<GMSOverlay>()
    
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
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return self.didHandleTap(marker)
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) -> Void {
        return self.didHandleTapOverlay(overlay)
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

extension GMSMapViewDelegateProxy {
    
    public func didHandleTap(_ marker: GMSMarker) -> Bool {
        didTapMarkerEvent.onNext(marker)
        return handleTapMarker?(marker) ?? false
    }
    
    public func didHandleTapOverlay(_ overlay: GMSOverlay) -> Void {
        didTapOverlayEvent.onNext(overlay)
        return handleTapOverlay?(overlay) ?? ()
    }
    
    public func didTapMyLocationButton() -> Bool {
        didTapMyLocationButtonEvent.onNext(())
        return handleTapMyLocationButton?() ?? false
    }
    
    public func markerInfoWindow(marker: GMSMarker) -> UIView? {
        return handleMarkerInfoWindow?(marker)
    }
    
    public func markerInfoContents(marker: GMSMarker) -> UIView? {
        return handleMarkerInfoContents?(marker)
    }
    
}

// - MARK: Internal Helpers
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
        fatalError("Failure converting from \(value ?? "") to \(T.self)")
    }
    
    return result
}
