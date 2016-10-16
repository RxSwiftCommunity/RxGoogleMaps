//
//  RxGMSGroundOverlay.swift
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
