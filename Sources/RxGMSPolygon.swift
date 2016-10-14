//
//  RxGMSPolygon.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 15..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
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
