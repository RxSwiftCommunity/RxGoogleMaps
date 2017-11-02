// Copyright (c) RxSwiftCommunity

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import RxSwift
import GoogleMaps
import RxGoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var actionButton0: UIButton!
    @IBOutlet weak var actionButton1: UIButton!
    
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.settings.myLocationButton = true

//        let startLocationManager = mapView.rx.didTapMyLocationButton.take(1).publish()
//        _ = startLocationManager.subscribe({ [weak self] _ in self?.locationManager.requestWhenInUseAuthorization() })
//        _ = startLocationManager.map { _ in true }.bind(to: mapView.rx.myLocationEnabled)
//        startLocationManager.connect().disposed(by: disposeBag)
        
        mapView.rx.handleMarkerInfoWindow { marker in
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 60))
            label.textAlignment = .center
            label.textColor = UIColor.brown
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.backgroundColor = UIColor.yellow
            label.text = marker.title
            return label
        }
        
        mapView.rx.willMove.asDriver()
            .drive(onNext: { _ in
                print("Will move") })
            .disposed(by: disposeBag)

        mapView.rx.didChange.asDriver()
            .drive(onNext: {
                print("Did change position: \($0)") })
            .disposed(by: disposeBag)

        mapView.rx.idleAt
            .subscribe(onNext: { print("Idle at coordinate: \($0)") })
            .disposed(by: disposeBag)

        mapView.rx.didTapAt.asDriver()
            .drive(onNext: { print("Did tap at coordinate: \($0)") })
            .disposed(by: disposeBag)
        
        mapView.rx.didLongPressAt.asDriver()
            .drive(onNext: { print("Did long press at coordinate: \($0)") })
            .disposed(by: disposeBag)
        
        //Class doesnt respond to
//        mapView.rx.didTap.asDriver()
//            .drive(onNext: { print("Did tap marker: \($0)") })
//            .disposed(by: disposeBag)

        mapView.rx.didTapInfoWindowOf.asDriver()
            .drive(onNext: { print("Did tap info window of marker: \($0)") })
            .disposed(by: disposeBag)
        
        mapView.rx.didLongPressInfoWindowOf.asDriver()
            .drive(onNext: { print("Did long press info window of marker: \($0)") })
            .disposed(by: disposeBag)
        
        //Class doesnt respond to
//        mapView.rx.didTapOverlay.asDriver(onErrorJustReturn: GMSOverlay())
//            .drive(onNext: { print("Did tap overlay: \($0)") })
//            .disposed(by: disposeBag)

        mapView.rx.didTapAtPoi.asDriver()
            .drive(onNext: { (placeID, name, coordinate) in
                print("Did tap POI: [\(placeID)] \(name) (\(coordinate.latitude), \(coordinate.longitude))")
            })
            .disposed(by: disposeBag)
        
        //Class doesnt respond to
//        mapView.rx.didTapMyLocationButton.asDriver()
//            .drive(onNext: { _ in print("Did tap my location button") })
//            .disposed(by: disposeBag)

        mapView.rx.didCloseInfoWindowOfMarker.asDriver()
            .drive(onNext: { print("Did close info window of marker: \($0)") })
            .disposed(by: disposeBag)

        mapView.rx.didBeginDragging.asDriver()
            .drive(onNext: { print("Did begin dragging marker: \($0)") })
            .disposed(by: disposeBag)
        
        mapView.rx.didEndDragging.asDriver()
            .drive(onNext: { print("Did end dragging marker: \($0)") })
            .disposed(by: disposeBag)
        
        mapView.rx.didDrag.asDriver()
            .drive(onNext: { print("Did drag marker: \($0)") })
            .disposed(by: disposeBag)
        
        mapView.rx.didStartTileRendering
            .subscribe(onNext: { print("Did start tile rendering") })
            .disposed(by: disposeBag)
        
        mapView.rx.didFinishTileRendering
            .subscribe(onNext: { print("Did finish tile rendering") })
            .disposed(by: disposeBag)
        
        mapView.rx.snapshotReady
            .subscribe(onNext: { print("Snapshot ready") })
            .disposed(by: disposeBag)
        
        mapView.rx.myLocation
            .subscribe(onNext: { location in
                if let l = location {
                    print("My location: (\(l.coordinate.latitude), \(l.coordinate.longitude))")
                } else {
                    print("My location: nil")
                }
            })
            .disposed(by: disposeBag)
        
        mapView.rx.selectedMarker.asDriver()
            .drive(onNext: { selected in
                if let marker = selected {
                    print("Selected marker: \(marker.title ?? "") (\(marker.position.latitude), \(marker.position.longitude))")
                } else {
                    print("Selected marker: nil")
                }
            })
            .disposed(by: disposeBag)
        
        do {
            let s0 = mapView.rx.selectedMarker.asObservable()
            let s1 = s0.skip(1)
            
            Observable.zip(s0, s1) { ($0, $1) }
                .subscribe(onNext: { (prev, cur) in
                    if let marker = prev {
                        marker.icon = #imageLiteral(resourceName: "marker_normal")
                    }
                    if let marker = cur {
                        marker.icon = #imageLiteral(resourceName: "marker_selected")
                    }
                })
                .disposed(by: disposeBag)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let center = CLLocationCoordinate2D(latitude: 33.3659424, longitude: 126.3476852)
        let place0 = CLLocationCoordinate2D(latitude: 33.4108625, longitude: 126.391319)
        
        let camera = GMSCameraPosition.camera(withLatitude: center.latitude, longitude: center.longitude, zoom: 12, bearing: 30, viewingAngle: 45)
        mapView.camera = camera
        
        do {
            let marker = GMSMarker(position: center)
            marker.title = "Hello, RxSwift"
            marker.isDraggable = true
            marker.icon = #imageLiteral(resourceName: "marker_normal")
            marker.map = mapView
            
//            actionButton0.rx.tap.map{ _ in marker }
//                .bindTo(mapView.rx.selectedMarker.asObserver())
//                .disposed(by: disposeBag)

//            actionButton0.rx.tap.map{ 180.0 }
//                .bindTo(marker.rx.rotation.asObserver())
//                .disposed(by: disposeBag)
//            
//            actionButton1.rx.tap.map{ 0 }
//                .bindTo(marker.rx.rotation.asObserver())
//                .disposed(by: disposeBag)

        }

        do {
            let marker = GMSMarker(position: place0)
            marker.title = "Hello, GoogleMaps"
            marker.isDraggable = true
            marker.icon = #imageLiteral(resourceName: "marker_normal")
            marker.map = mapView

//            actionButton1.rx.tap.map{ _ in marker }
//                .bindTo(mapView.rx.selectedMarker.asObserver())
//                .disposed(by: disposeBag)
        }

        do {
            let circle = GMSCircle()
            circle.title = "Circle"
            circle.radius = 2000
            circle.isTappable = true
            circle.position = center
            circle.fillColor = UIColor.green.withAlphaComponent(0.3)
            circle.strokeColor = UIColor.green.withAlphaComponent(0.8)
            circle.strokeWidth = 4
            circle.map = mapView
            
//            actionButton0.rx.tap.map{ UIColor.red }
//                .bindTo(circle.rx.fillColor.asObserver())
//                .disposed(by: disposeBag)
//            
//            actionButton1.rx.tap.map{ UIColor.green }
//                .bindTo(circle.rx.fillColor.asObserver())
//                .disposed(by: disposeBag)

        }
        
        do {
//            actionButton0.rx.tap.map { true }
//                .bindTo(mapView.rx.trafficEnabled.asObserver())
//                .disposed(by: disposeBag)
//            actionButton1.rx.tap.map { false }
//                .bindTo(mapView.rx.trafficEnabled.asObserver())
//                .disposed(by: disposeBag)

//            actionButton0.rx.tap.map { 14 }
//                .bindTo(mapView.rx.zoomToAnimate)
//                .disposed(by: disposeBag)
            
//            actionButton1.rx.tap
//                .map { GMSCameraPosition.camera(withLatitude: place0.latitude, longitude: place0.longitude, zoom: 8, bearing: 10, viewingAngle: 30) }
//                .bindTo(mapView.rx.cameraToAnimate)
//                .disposed(by: disposeBag)
            
            
//            actionButton0.rx.tap.map { true }
//                .bindTo(mapView.rx.zoomGesturesEnabled)
//                .disposed(by: disposeBag)
//            actionButton1.rx.tap.map { false }
//                .bindTo(mapView.rx.zoomGesturesEnabled)
//                .disposed(by: disposeBag)

        }
    }

}
