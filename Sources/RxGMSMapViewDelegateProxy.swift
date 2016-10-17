// Copyright (c) RxSwiftCommunity

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit
import CoreLocation
import RxSwift
import RxCocoa

public typealias RxGMSHandleTapMarker = (RxGMSMarker) -> (Bool)
public typealias RxGMSHandleTapMyLocationButton = () -> (Bool)
public typealias RxGMSHandleMarkerInfoView = (RxGMSMarker) -> (UIView?)

public class RxGMSMapViewDelegateProxy
    : DelegateProxy
    , RxGMSMapViewDelegate
    , DelegateProxyType {
    
    var handleTapMarker: RxGMSHandleTapMarker? = nil
    var handleTapMyLocationButton: RxGMSHandleTapMyLocationButton? = nil
    var handleMarkerInfoWindow: RxGMSHandleMarkerInfoView? = nil
    var handleMarkerInfoContents: RxGMSHandleMarkerInfoView? = nil
    
    let didTapMarkerEvent = PublishSubject<RxGMSMarker>()
    let didTapMyLocationButtonEvent = PublishSubject<Void>()
    
    /**
     For more information take a look at `DelegateProxyType`.
     */
    public class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let mapView: RxGMSMapView = castOrFatalError(object)
        mapView.delegateWrapper = castOptionalOrFatalError(delegate)
    }
    
    /**
     For more information take a look at `DelegateProxyType`.
     */
    public class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let mapView: RxGMSMapView = castOrFatalError(object)
        return mapView.delegateWrapper
    }
    
}

// For delegates that needs return types

extension RxGMSMapViewDelegateProxy {

    public func didHandleTap(_ marker: RxGMSMarker) -> Bool {
        didTapMarkerEvent.onNext(marker)
        return handleTapMarker?(marker) ?? false
    }
    
    public func didTapMyLocationButton() -> Bool {
        didTapMyLocationButtonEvent.onNext()
        return handleTapMyLocationButton?() ?? false
    }

    public func markerInfoWindow(marker: RxGMSMarker) -> UIView? {
        return handleMarkerInfoWindow?(marker)
    }
    
    public func markerInfoContents(marker: RxGMSMarker) -> UIView? {
        return handleMarkerInfoContents?(marker)
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

