//
//  GMSGroundOverlay+Rx.swift
//  Example
//
//  Created by Gabriel Araujo on 30/10/17.
//  Copyright © 2017 Gen X Hippies Company. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import RxSwift
import RxCocoa
import GoogleMaps

public extension Reactive where Base: GMSGroundOverlay {
    
    public var position: AnyObserver<CLLocationCoordinate2D> {
        return Binder(base) { control, position in
            control.position = position
        }.asObserver()
    }
    
    public var anchor: AnyObserver<CGPoint> {
        return Binder(base) { control, anchor in
            control.anchor = anchor
        }.asObserver()
    }
    
    public var icon: AnyObserver<UIImage?> {
        return Binder(base) { control, icon in
            control.icon = icon
        }.asObserver()
    }
    
    public var opacity: AnyObserver<Float> {
        return Binder(base) { control, opacity in
            control.opacity = opacity
        }.asObserver()
    }
    
    public var bearing: AnyObserver<CLLocationDirection> {
        return Binder(base) { control, bearing in
            control.bearing = bearing
        }.asObserver()
    }
    
}
