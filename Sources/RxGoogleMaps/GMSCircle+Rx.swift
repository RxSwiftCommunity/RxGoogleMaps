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
    var position: Binder<CLLocationCoordinate2D> {
        return Binder(base) { control, position in
            control.position = position
        }
    }
    
    var radius: Binder<CLLocationDistance> {
        return Binder(base) { control, radius in
            control.radius = radius
        }
    }
    
    var strokeWidth: Binder<CGFloat> {
        return Binder(base) { control, strokeWidth in
            control.strokeWidth = strokeWidth
        }
    }
    
    var strokeColor: Binder<UIColor?> {
        return Binder(base) { control, strokeColor in
            control.strokeColor = strokeColor
        }
    }
    
    var fillColor: Binder<UIColor?> {
        return Binder(base) { control, fillColor in
            control.fillColor = fillColor
        }
    }
}
