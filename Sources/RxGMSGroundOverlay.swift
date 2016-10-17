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

@objc public protocol RxGMSGroundOverlay: RxGMSOverlay {
    
    var position: CLLocationCoordinate2D { get set }
    var anchor: CGPoint { get set }
    var icon: UIImage? { get set }
    var opacity: Float { get set }
    var bearing: CLLocationDirection { get set }
    
}

public extension Reactive where Base: RxGMSGroundOverlay {
    
    public var position: AnyObserver<CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: base) { control, position in
            control.position = position
        }.asObserver()
    }
    
    public var anchor: AnyObserver<CGPoint> {
        return UIBindingObserver(UIElement: base) { control, anchor in
            control.anchor = anchor
        }.asObserver()
    }
    
    public var icon: AnyObserver<UIImage?> {
        return UIBindingObserver(UIElement: base) { control, icon in
            control.icon = icon
        }.asObserver()
    }
    
    public var opacity: AnyObserver<Float> {
        return UIBindingObserver(UIElement: base) { control, opacity in
            control.opacity = opacity
        }.asObserver()
    }
    
    public var bearing: AnyObserver<CLLocationDirection> {
        return UIBindingObserver(UIElement: base) { control, bearing in
            control.bearing = bearing
        }.asObserver()
    }
    
}
