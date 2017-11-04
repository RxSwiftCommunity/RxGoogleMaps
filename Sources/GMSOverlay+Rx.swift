//
//  GMSOverlay+Rx.swift
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

public extension Reactive where Base: GMSOverlay {
    
    public var title: AnyObserver<String?> {
        return Binder(base) { control, title in
            control.title = title
        }.asObserver()
    }
    
    public var tappable: AnyObserver<Bool> {
        return Binder(base) { control, tappable in
            control.isTappable = tappable
        }.asObserver()
    }
    
    public var zIndex: AnyObserver<Int32> {
        return Binder(base) { control, zIndex in
            control.zIndex = zIndex
        }.asObserver()
    }
    
}
