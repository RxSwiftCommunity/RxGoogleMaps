//
//  RxGMSCircle.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 15..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import RxCocoa
import RxSwift

@objc public protocol RxGMSCircle: RxGMSOverlay {
   
    var position: CLLocationCoordinate2D { get set }
    var radius: CLLocationDistance { get set }
    var strokeWidth: CGFloat { get set }
    var strokeColor: UIColor? { get set }
    var fillColor: UIColor? { get set }

}

public extension Reactive where Base: RxGMSCircle {
    
    public var position: AnyObserver<CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: base) { control, position in
            control.position = position
        }.asObserver()
    }
    
    public var radius: AnyObserver<CLLocationDistance> {
        return UIBindingObserver(UIElement: base) { control, radius in
            control.radius = radius
        }.asObserver()
    }
    
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
