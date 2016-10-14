//
//  RxGMSOverlay.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 14..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import CoreLocation
import RxCocoa
import RxSwift

@objc public protocol RxGMSOverlay: class {
    
    var title: String? { get set }
    var tappable: Bool { @objc(isTappable) get set }
    var zIndex: Int32 { get set }
    
    //weak var map: RxGMSMapView? { get set }
    
}

public extension Reactive where Base: RxGMSOverlay {

    public var title: AnyObserver<String?> {
        return UIBindingObserver(UIElement: base) { control, title in
            control.title = title
        }.asObserver()
    }

    public var tappable: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: base) { control, tappable in
            control.tappable = tappable
        }.asObserver()
    }
    
    public var zIndex: AnyObserver<Int32> {
        return UIBindingObserver(UIElement: base) { control, zIndex in
            control.zIndex = zIndex
        }.asObserver()
    }
    
}
