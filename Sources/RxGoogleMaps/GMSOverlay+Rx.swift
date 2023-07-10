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
    var title: Binder<String?> {
        return Binder(base) { control, title in
            control.title = title
        }
    }
    
    var tappable: Binder<Bool> {
        return Binder(base) { control, tappable in
            control.isTappable = tappable
        }
    }
    
    var zIndex: Binder<Int32> {
        return Binder(base) { control, zIndex in
            control.zIndex = zIndex
        }
    }
}
