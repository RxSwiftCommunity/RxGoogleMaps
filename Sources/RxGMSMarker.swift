//
//  RxGMSMarker.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 14..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import RxCocoa
import RxSwift

@objc public protocol RxGMSMarker: RxGMSOverlay {
    
    var position: CLLocationCoordinate2D { get set }
    var snippet: String? { get set }
    var icon: UIImage? { get set }
    var iconView: UIView? { get set }
    var tracksViewChanges: Bool { get set }
    var tracksInfoWindowChanges: Bool { get set }
    var groundAnchor: CGPoint { get set }
    var infoWindowAnchor: CGPoint { get set }
    var draggable: Bool { @objc(isDraggable) get set }
    var flat: Bool { @objc(isFlat) get set }
    var rotation: CLLocationDegrees { get set }
    var opacity: Float { get set }
    var userData: Any? { get set }
    
    //var appearAnimation: GMSMarkerAnimation { get set }
    //var layer: GMSMarkerLayer { get }
    //weak var panoramaView: GMSPanoramaView? { get set }
    
}

public extension Reactive where Base: RxGMSMarker {
    
    public var position: AnyObserver<CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: base) { control, position in
            control.position = position
        }.asObserver()
    }
    
    public var snippet: AnyObserver<String?> {
        return UIBindingObserver(UIElement: base) { control, snippet in
            control.snippet = snippet
        }.asObserver()
    }
    
    public var icon: AnyObserver<UIImage?> {
        return UIBindingObserver(UIElement: base) { control, icon in
            control.icon = icon
        }.asObserver()
    }
    
    public var iconView: AnyObserver<UIView?> {
        return UIBindingObserver(UIElement: base) { control, iconView in
            control.iconView = iconView
        }.asObserver()
    }
    
    public var groundAnchor: AnyObserver<CGPoint> {
        return UIBindingObserver(UIElement: base) { control, groundAnchor in
            control.groundAnchor = groundAnchor
        }.asObserver()
    }
    
    public var infoWindowAnchor: AnyObserver<CGPoint> {
        return UIBindingObserver(UIElement: base) { control, infoWindowAnchor in
            control.infoWindowAnchor = infoWindowAnchor
        }.asObserver()
    }
    
    public var draggable: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, draggable in
            control.draggable = draggable
        }.asObserver()
    }
    
    public var rotation: AnyObserver<CLLocationDegrees> {
        return UIBindingObserver(UIElement: base) { control, rotation in
            control.rotation = rotation
        }.asObserver()
    }
    
    public var opacity: AnyObserver<Float> {
        return UIBindingObserver(UIElement: base) { control, opacity in
            control.opacity = opacity
        }.asObserver()
    }
    
    public var userData: AnyObserver<Any?> {
        return UIBindingObserver(UIElement: base) { control, userData in
            control.userData = userData
        }.asObserver()
    }

}
