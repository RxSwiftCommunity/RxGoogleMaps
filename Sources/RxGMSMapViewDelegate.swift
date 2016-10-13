//
//  RxGMSMapViewDelegate.swift
//  RxGoogleMaps
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 10..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//


import Foundation
import RxSwift

public protocol RxGMSMapViewDelegate: class {
    
    func mapView(_ mapView: GMSMapViewWrapper, didHandleTap marker: GMSMarkerWrapper) -> Bool
    
}
