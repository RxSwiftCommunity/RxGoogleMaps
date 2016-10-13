//
//  RxGMSMapViewDelegateProxy.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 10..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa
import UIKit

public class RxGMSMapViewDelegateProxy
    : DelegateProxy
    , GMSMapViewDelegateWrapper
    , DelegateProxyType {
    
    weak var delegate: RxGMSMapViewDelegate? = nil
    
    let didTapMarker = PublishSubject<GMSMarkerWrapper>()
    
    /**
     For more information take a look at `DelegateProxyType`.
     */
    public class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let mapView: GMSMapViewWrapper = castOrFatalError(object)
        mapView.delegateWrapper = castOptionalOrFatalError(delegate)
    }
    
    /**
     For more information take a look at `DelegateProxyType`.
     */
    public class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let mapView: GMSMapViewWrapper = castOrFatalError(object)
        return mapView.delegateWrapper
    }
    
}

extension RxGMSMapViewDelegateProxy {

    public func mapView(_ mapView: GMSMapViewWrapper, didHandleTap marker: GMSMarkerWrapper) -> Bool {
        didTapMarker.onNext(marker)
        return delegate?.mapView(mapView, didHandleTap: marker) ?? false
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

