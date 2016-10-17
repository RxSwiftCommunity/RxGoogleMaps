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
