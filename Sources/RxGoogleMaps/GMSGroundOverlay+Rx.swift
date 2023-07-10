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
    var position: Binder<CLLocationCoordinate2D> {
        return Binder(base) { control, position in
            control.position = position
        }
    }
    
    var anchor: Binder<CGPoint> {
        return Binder(base) { control, anchor in
            control.anchor = anchor
        }
    }
    
    var icon: Binder<UIImage?> {
        return Binder(base) { control, icon in
            control.icon = icon
        }
    }
    
    var opacity: Binder<Float> {
        return Binder(base) { control, opacity in
            control.opacity = opacity
        }
    }
    
    var bearing: Binder<CLLocationDirection> {
        return Binder(base) { control, bearing in
            control.bearing = bearing
        }
    }
}
