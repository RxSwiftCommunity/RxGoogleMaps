//
//  GMSCircle+Rx.swift
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

public extension Reactive where Base: GMSCircle {
    
    public var position: AnyObserver<CLLocationCoordinate2D> {
        return Binder(base) { control, position in
            control.position = position
        }.asObserver()
    }
    
    public var radius: AnyObserver<CLLocationDistance> {
        return Binder(base) { control, radius in
            control.radius = radius
        }.asObserver()
    }
    
    public var strokeWidth: AnyObserver<CGFloat> {
        return Binder(base) { control, strokeWidth in
            control.strokeWidth = strokeWidth
        }.asObserver()
    }
    
    public var strokeColor: AnyObserver<UIColor?> {
        return Binder(base) { control, strokeColor in
            control.strokeColor = strokeColor
        }.asObserver()
    }
    
    public var fillColor: AnyObserver<UIColor?> {
        return Binder(base) { control, fillColor in
            control.fillColor = fillColor
        }.asObserver()
    }
    
}
