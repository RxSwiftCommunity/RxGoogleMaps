//
//  RxGoogleMapsTests.swift
//  RxGoogleMapsTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 10..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

import Nimble
import GoogleMaps
import RxSwift
import RxCocoa
import RxGoogleMaps

@testable import RxGoogleMaps

class RxGoogleMapsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        GMSServices.provideAPIKey("Google_Maps_API_Key_Here")
    }
    
    func test_willMove() {
        let mapView: GMSMapView = GMSMapView()
        
        do {
            let disposeBag = DisposeBag()
            var subscribed = false
            mapView.rx.willMove.asObservable()
                .subscribe(onNext: {
                    subscribed = true
                    expect($0.byGesture).to(beTrue())
                })
                .addDisposableTo(disposeBag)
            
            mapView.delegate!.mapView!(mapView, willMove: true)
            expect(subscribed).to(beTrue())

        }

        do {
            let disposeBag = DisposeBag()
            var subscribed = false
            mapView.rx.willMove.asObservable()
                .subscribe(onNext: {
                    subscribed = true
                    expect($0.byGesture).to(beFalse())
                })
                .addDisposableTo(disposeBag)

            let camera = GMSCameraPosition.camera(withLatitude: -33, longitude: 151, zoom: 6, bearing: 30, viewingAngle: 45)
            mapView.animate(to: camera)
            //mapView.camera = camera
            expect(subscribed).toEventually(beTrue())
        }
    }
    
}
