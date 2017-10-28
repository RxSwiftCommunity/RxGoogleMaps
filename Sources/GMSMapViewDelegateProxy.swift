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

class GMSMapViewDelegateProxy : DelegateProxy<GMSMapView, GMSMapViewDelegate>, DelegateProxyType, GMSMapViewDelegate {
    
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
