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
    
    public var position: AnyObserver<CLLocationCoordinate2D> {
        return Binder(base) { control, position in
            control.position = position
        }.asObserver()
    }
    
    public var snippet: AnyObserver<String?> {
        return Binder(base) { control, snippet in
            control.snippet = snippet
        }.asObserver()
    }
    
    public var icon: AnyObserver<UIImage?> {
        return Binder(base) { control, icon in
            control.icon = icon
        }.asObserver()
    }
    
    public var iconView: AnyObserver<UIView?> {
        return Binder(base) { control, iconView in
            control.iconView = iconView
        }.asObserver()
    }
    
    public var groundAnchor: AnyObserver<CGPoint> {
        return Binder(base) { control, groundAnchor in
            control.groundAnchor = groundAnchor
        }.asObserver()
    }
    
    public var infoWindowAnchor: AnyObserver<CGPoint> {
        return Binder(base) { control, infoWindowAnchor in
            control.infoWindowAnchor = infoWindowAnchor
        }.asObserver()
    }
    
    public var draggable: AnyObserver<Bool> {
        return Binder(base) { control, draggable in
            control.isDraggable = draggable
        }.asObserver()
    }
    
    public var flat: AnyObserver<Bool> {
        return Binder(base) { control, flat in
            control.isFlat = flat
        }.asObserver()
    }
    
    public var rotation: AnyObserver<CLLocationDegrees> {
        return Binder(base) { control, rotation in
            control.rotation = rotation
        }.asObserver()
    }
    
    public var opacity: AnyObserver<Float> {
        return Binder(base) { control, opacity in
            control.opacity = opacity
        }.asObserver()
    }
    
    public var userData: AnyObserver<Any?> {
        return Binder(base) { control, userData in
            control.userData = userData
        }.asObserver()
    }
    
}
