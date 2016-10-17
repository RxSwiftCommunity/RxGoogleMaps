/// Copyright (c) RxSwiftCommunity

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
import RxCocoa
import RxSwift

extension Reactive where Base: RxGMSMapView {
    
    fileprivate var delegateProxy: RxGMSMapViewDelegateProxy {
        return RxGMSMapViewDelegateProxy.proxyForObject(base)
    }
 
    public func handleTapMarkerWrapper(_ closure: RxGMSHandleTapMarker?) {
        delegateProxy.handleTapMarker = closure
    }
    
    public func handleMarkerInfoWindowWrapper(_ closure: RxGMSHandleMarkerInfoView?) {
        delegateProxy.handleMarkerInfoWindow = closure
    }
    
    public func handleMarkerInfoContentsWrapper(_ closure: RxGMSHandleMarkerInfoView?) {
        delegateProxy.handleMarkerInfoContents = closure
    }

    public func handleTapMyLocationButton(_ closure: RxGMSHandleTapMyLocationButton?) {
        delegateProxy.handleTapMyLocationButton = closure
    }
}

// GMSMapView delegate

public extension Reactive where Base: RxGMSMapView {

    private func methodInvokedWithParam1<T>(_ selector: Selector) -> Observable<T> {
        return delegateProxy
            .methodInvoked(selector)
            .map { a in return try castOrThrow(T.self, a[1]) }
    }
    
    private func controlEventWithParam1<T>(_ selector: Selector) -> ControlEvent<T> {
        return ControlEvent(events: methodInvokedWithParam1(selector))
    }
    
    /**
     Wrapper of: func mapView(_ mapView: GMSMapView, willMove gesture: Bool)
     */
    public var willMove: ControlEvent<RxGMSGestureProperty> {
        return ControlEvent(events:
            methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:willMove:)))
                .map(RxGMSGestureProperty.init)
        )
    }
    
    public var didChangePositionWrapper: Observable<RxGMSCameraPosition> {
        return methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didChangeCameraPosition:)))
    }
    
    public var idleAtPositionWrapper: Observable<RxGMSCameraPosition> {
        return methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:idleAtCameraPosition:)))
    }
    
    /**
     Wrapper of: mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)
     */
    public var didTapAt: ControlEvent<CLLocationCoordinate2D> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:didTapAtCoordinate:)))
            .map { a in
                return try castCoordinateOrThrow(a[1])
        }
        
        return ControlEvent(events: source)
    }

    /**
     Wrapper of: func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D)
     */
    public var didLongPressAt: ControlEvent<CLLocationCoordinate2D> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:didLongPressAtCoordinate:)))
            .map { a in
                return try castCoordinateOrThrow(a[1])
        }
        
        return ControlEvent(events: source)
    }
    
    public var didTapMarkerWrapper: Observable<RxGMSMarker> {
        return delegateProxy.didTapMarkerEvent
    }
    
    public var didTapInfoWindowWrapper: Observable<RxGMSMarker> {
        return methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didTapInfoWindowOfMarker:)))
    }
    
    public var didLongPressInfoWindowWrapper: Observable<RxGMSMarker> {
        return methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didLongPressInfoWindowOfMarker:)))
    }
    
    public var didTapOverlayWrapper: Observable<RxGMSOverlay> {
        return methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didTapOverlay:)))
    }

    /**
     Wrapper of: func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay)
     */
    public var didTapPOI: ControlEvent<(placeID: String, name: String, location: CLLocationCoordinate2D)> {
        let source = delegateProxy
            .methodInvoked(#selector(RxGMSMapViewDelegate.mapView(_:didTapPOIWithPlaceID:name:location:)))
            .map { a -> (placeID: String, name: String, location: CLLocationCoordinate2D)in
                let placeID = try castOrThrow(NSString.self, a[1]) as String
                let name = try castOrThrow(NSString.self, a[2]) as String
                
                let value = try castOrThrow(NSValue.self, a[3])
                var coordinate = CLLocationCoordinate2D()
                value.getValue(&coordinate)
                return (placeID, name, coordinate)
        }

        return ControlEvent(events: source)
    }

    /**
     Wrapper of: func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D)
     */
    public var didTapMyLocationButton: ControlEvent<Void> {
        return ControlEvent(events: delegateProxy.didTapMyLocationButtonEvent)
    }

    public var didCloseInfoWindowWrapper: Observable<RxGMSMarker> {
        return methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didCloseInfoWindowOfMarker:)))
    }

    public var didBeginDraggingMarkerWrapper: Observable<RxGMSMarker> {
        return methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didBeginDraggingMarker:)))
    }

    public var didEndDraggingMarkerWrapper: Observable<RxGMSMarker> {
        return methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didEndDraggingMarker:)))
    }

    public var didDragMarkerWrapper: Observable<RxGMSMarker> {
        return methodInvokedWithParam1(#selector(RxGMSMapViewDelegate.mapView(_:didDragMarker:)))
    }

    /**
     Wrapper of: func mapViewDidStartTileRendering(_ mapView: GMSMapView)
     */
    public var didStartTileRendering: ControlEvent<Void> {
        return ControlEvent(events:
            delegateProxy
                .methodInvoked(#selector(RxGMSMapViewDelegate.mapViewDidStartTileRendering(_:)))
                .map{ _ in return }
        )
    }
    
    /**
     Wrapper of: func mapViewDidFinishTileRendering(_ mapView: GMSMapView)
     */
    public var didFinishTileRendering: ControlEvent<Void> {
        return ControlEvent(events:
            delegateProxy
                .methodInvoked(#selector(RxGMSMapViewDelegate.mapViewDidFinishTileRendering(_:)))
                .map{ _ in return }
        )
    }
    
    /**
     Wrapper of: func mapViewSnapshotReady(_ mapView: GMSMapView)
     */
    public var snapshotReady: ControlEvent<Void> {
        return ControlEvent(events:
            delegateProxy
                .methodInvoked(#selector(RxGMSMapViewDelegate.mapViewSnapshotReady(_:)))
                .map{ _ in return }
        )
    }
}

// GMSMapView properties (camera & animate)

public extension Reactive where Base: RxGMSMapView, Base: UIView {
    
    public var camera: AnyObserver<RxGMSCameraPosition> {
        return UIBindingObserver(UIElement: base) { control, camera in
            control.cameraWrapper = camera
        }.asObserver()
    }
    
    public var cameraToAnimate: AnyObserver<RxGMSCameraPosition> {
        return UIBindingObserver(UIElement: base) { control, camera in
            control.animateWrapper(to: camera)
        }.asObserver()
    }
    
    public var locationToAnimate: AnyObserver<CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: base) { control, location in
            control.animate(toLocation: location)
        }.asObserver()
    }
    
    public var zoomToAnimate: AnyObserver<Float> {
        return UIBindingObserver(UIElement: base) { control, zoom in
            control.animate(toZoom: zoom)
        }.asObserver()
    }
    
    public var bearingToAnimate: AnyObserver<CLLocationDirection> {
        return UIBindingObserver(UIElement: base) { control, bearing in
            control.animate(toBearing: bearing)
        }.asObserver()
    }
    
    public var viewingAngleToAnimate: AnyObserver<Double> {
        return UIBindingObserver(UIElement: base) { control, viewingAngle in
            control.animate(toViewingAngle: viewingAngle)
        }.asObserver()
    }
    
}

// GMSMapView properties

public extension Reactive where Base: RxGMSMapView, Base: UIView {

    public var myLocationEnabled: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, myLocationEnabled in
            control.myLocationEnabled = myLocationEnabled
        }.asObserver()
    }

    public var myLocation: Observable<CLLocation?> {
        return observeWeakly(CLLocation.self, "myLocation")
    }
    
    public var selectedMarker: ControlProperty<RxGMSMarker?> {
        return ControlProperty(values: observeWeakly(RxGMSMarker.self, "selectedMarker"),
                               valueSink: UIBindingObserver(UIElement: base) { control, selectedMarker in
                                       control.selectedMarkerWrapper = selectedMarker
                                   }.asObserver()
        )
    }
    
    public var trafficEnabled: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, trafficEnabled in
            control.trafficEnabled = trafficEnabled
        }.asObserver()
    }
    
    public var padding: AnyObserver<UIEdgeInsets> {
        return UIBindingObserver(UIElement: base) { control, padding in
            control.padding = padding
        }.asObserver()
    }
}

// GMSMapView settings (GMSUISettings) properties

public extension Reactive where Base: RxGMSMapView, Base: UIView {
    
    public var scrollGesturesEnabled: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, scrollGestures in
            control.settingsWrapper.scrollGestures = scrollGestures
        }.asObserver()
    }
    
    public var zoomGesturesEnabled: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, zoomGestures in
            control.settingsWrapper.zoomGestures = zoomGestures
        }.asObserver()
    }
    
    public var tiltGesturesEnabled: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, tiltGestures in
            control.settingsWrapper.tiltGestures = tiltGestures
        }.asObserver()
    }
    
    public var rotateGesturesEnabled: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, rotateGestures in
            control.settingsWrapper.rotateGestures = rotateGestures
        }.asObserver()
    }
    
    public var compassButtonVisible: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, compassButton in
            control.settingsWrapper.compassButton = compassButton
        }.asObserver()
    }
    
    public var myLocationButtonVisible: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, myLocationButton in
            control.settingsWrapper.myLocationButton = myLocationButton
        }.asObserver()
    }
    
}

//

public struct RxGMSGestureProperty {
    public let byGesture: Bool
}

fileprivate func castCoordinateOrThrow(_ object: Any) throws -> CLLocationCoordinate2D {
    let value = try castOrThrow(NSValue.self, object)
    var coordinate = CLLocationCoordinate2D()
    value.getValue(&coordinate)
    return coordinate
}
