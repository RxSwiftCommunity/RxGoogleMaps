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

@objc public protocol RxGMSPolygon: RxGMSOverlay {
    
    var strokeWidth: CGFloat { get set }
    var strokeColor: UIColor? { get set }
    var fillColor: UIColor? { get set }
}

public extension Reactive where Base: RxGMSPolygon {
    
    public var strokeWidth: AnyObserver<CGFloat> {
        return UIBindingObserver(UIElement: base) { control, strokeWidth in
            control.strokeWidth = strokeWidth
            }.asObserver()
    }
    
    public var strokeColor: AnyObserver<UIColor?> {
        return UIBindingObserver(UIElement: base) { control, strokeColor in
            control.strokeColor = strokeColor
            }.asObserver()
    }
    
    public var fillColor: AnyObserver<UIColor?> {
        return UIBindingObserver(UIElement: base) { control, fillColor in
            control.fillColor = fillColor
        }.asObserver()
    }
    
}
