//
//  GMSMarker+Rx.swift
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

public extension Reactive where Base: GMSMarker {
    var position: Binder<CLLocationCoordinate2D> {
        return Binder(base) { control, position in
            control.position = position
        }
    }
    
    var snippet: Binder<String?> {
        return Binder(base) { control, snippet in
            control.snippet = snippet
        }
    }
    
    var icon: Binder<UIImage?> {
        return Binder(base) { control, icon in
            control.icon = icon
        }
    }
    
    var iconView: Binder<UIView?> {
        return Binder(base) { control, iconView in
            control.iconView = iconView
        }
    }
    
    var groundAnchor: Binder<CGPoint> {
        return Binder(base) { control, groundAnchor in
            control.groundAnchor = groundAnchor
        }
    }
    
    var infoWindowAnchor: Binder<CGPoint> {
        return Binder(base) { control, infoWindowAnchor in
            control.infoWindowAnchor = infoWindowAnchor
        }
    }
    
    var draggable: Binder<Bool> {
        return Binder(base) { control, draggable in
            control.isDraggable = draggable
        }
    }
    
    var flat: Binder<Bool> {
        return Binder(base) { control, flat in
            control.isFlat = flat
        }
    }
    
    var rotation: Binder<CLLocationDegrees> {
        return Binder(base) { control, rotation in
            control.rotation = rotation
        }
    }
    
    var opacity: Binder<Float> {
        return Binder(base) { control, opacity in
            control.opacity = opacity
        }
    }
    
    var userData: Binder<Any?> {
        return Binder(base) { control, userData in
            control.userData = userData
        }
    }
}
