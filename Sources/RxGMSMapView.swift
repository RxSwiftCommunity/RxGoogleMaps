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




