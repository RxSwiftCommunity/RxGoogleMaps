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
import RxCocoa
import RxSwift

@objc public protocol RxGMSMarker: RxGMSOverlay {
    
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
    
    //var appearAnimation: GMSMarkerAnimation { get set }
    //var layer: GMSMarkerLayer { get }
    //weak var panoramaView: GMSPanoramaView? { get set }
    
}

public extension Reactive where Base: RxGMSMarker {
    
    public var position: AnyObserver<CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: base) { control, position in
            control.position = position
        }.asObserver()
    }
    
    public var snippet: AnyObserver<String?> {
        return UIBindingObserver(UIElement: base) { control, snippet in
            control.snippet = snippet
        }.asObserver()
    }
    
    public var icon: AnyObserver<UIImage?> {
        return UIBindingObserver(UIElement: base) { control, icon in
            control.icon = icon
        }.asObserver()
    }
    
    public var iconView: AnyObserver<UIView?> {
        return UIBindingObserver(UIElement: base) { control, iconView in
            control.iconView = iconView
        }.asObserver()
    }
    
    public var groundAnchor: AnyObserver<CGPoint> {
        return UIBindingObserver(UIElement: base) { control, groundAnchor in
            control.groundAnchor = groundAnchor
        }.asObserver()
    }
    
    public var infoWindowAnchor: AnyObserver<CGPoint> {
        return UIBindingObserver(UIElement: base) { control, infoWindowAnchor in
            control.infoWindowAnchor = infoWindowAnchor
        }.asObserver()
    }
    
    public var draggable: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, draggable in
            control.draggable = draggable
        }.asObserver()
    }
    
    public var rotation: AnyObserver<CLLocationDegrees> {
        return UIBindingObserver(UIElement: base) { control, rotation in
            control.rotation = rotation
        }.asObserver()
    }
    
    public var opacity: AnyObserver<Float> {
        return UIBindingObserver(UIElement: base) { control, opacity in
            control.opacity = opacity
        }.asObserver()
    }
    
    public var userData: AnyObserver<Any?> {
        return UIBindingObserver(UIElement: base) { control, userData in
            control.userData = userData
        }.asObserver()
    }

}
