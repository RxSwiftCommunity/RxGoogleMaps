//
//  ViewController.swift
//  Example
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 10..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import UIKit
import RxSwift
import GoogleMaps
import RxGoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true

        mapView.rx.handleTapMarker { marker in
            print("Handle tap marker: \(marker.title ?? "") (\(marker.position.latitude), \(marker.position.longitude))")
            return false
        }
        
        mapView.rx.handleMarkerInfoWindow { marker in
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 60))
            label.textAlignment = .center
            label.textColor = UIColor.brown
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.backgroundColor = UIColor.yellow
            label.text = marker.title
            return label
        }
        
        mapView.rx.handleTapMyLocationButton {
            print("Handle my location button")
            return false
        }
        
        mapView.rx.willMove.asDriver()
            .drive(onNext: { print("Gesture: \($0.byGesture)") })
            .addDisposableTo(disposeBag)

        mapView.rx.didChange.asDriver()
            .drive(onNext: { print("Did change position: (\($0.target.latitude), \($0.target.longitude))") })
            .addDisposableTo(disposeBag)

        mapView.rx.idleAt.asDriver()
            .drive(onNext: { print("Idle at: (\($0.target.latitude), \($0.target.longitude))") })
            .addDisposableTo(disposeBag)

        mapView.rx.didTapAt.asDriver()
            .drive(onNext: { print("Did tap at: (\($0.latitude), \($0.longitude))") })
            .addDisposableTo(disposeBag)
        
        mapView.rx.didLongPressAt.asDriver()
            .drive(onNext: { print("Did long press at: (\($0.latitude), \($0.longitude))") })
            .addDisposableTo(disposeBag)
        
        mapView.rx.didTapMarker.asDriver()
            .drive(onNext: { print("Did tap marker: \($0.title ?? "") (\($0.position.latitude), \($0.position.longitude))") })
            .addDisposableTo(disposeBag)
        
        mapView.rx.didTapInfoWindow.asDriver()
            .drive(onNext: { print("Did tap info window: \($0.title ?? "") (\($0.position.latitude), \($0.position.longitude))") })
            .addDisposableTo(disposeBag)
        
        mapView.rx.didLongPressInfoWindow.asDriver()
            .drive(onNext: { print("Did long press info window: (\($0.position.latitude), \($0.position.longitude))") })
            .addDisposableTo(disposeBag)
        
        mapView.rx.didTapOverlay.asDriver()
            .drive(onNext: { print("Did tap overlay: \($0.title ?? "")") })
            .addDisposableTo(disposeBag)

        mapView.rx.didTapPOI.asDriver()
            .drive(onNext: { (placeID, name, coordinate) in
                print("Did tap POI: [\(placeID)] \(name) (\(coordinate.latitude), \(coordinate.longitude))")
            })
            .addDisposableTo(disposeBag)
        
        mapView.rx.didTapMyLocationButton.take(1).asObservable()
            .subscribe(onNext: { [weak self] in
                self?.locationManager.requestWhenInUseAuthorization()
            })
            .addDisposableTo(disposeBag)
        
        mapView.rx.didTapMyLocationButton.asDriver()
            .drive(onNext: { print("Did tap my location button") })
            .addDisposableTo(disposeBag)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let center = CLLocationCoordinate2D(latitude: 33.3659424, longitude: 126.3476852)
        
        let camera = GMSCameraPosition.camera(withLatitude: center.latitude, longitude: center.longitude, zoom: 12, bearing: 30, viewingAngle: 45)
        mapView.camera = camera
        
        let marker = GMSMarker(position: center)
        marker.title = "Hello, RxSwift"
        marker.map = mapView

        let circle = GMSCircle()
        circle.title = "Circle"
        circle.radius = 2000
        circle.isTappable = true
        circle.position = center
        circle.fillColor = UIColor.green.withAlphaComponent(0.3)
        circle.strokeColor = UIColor.green.withAlphaComponent(0.8)
        circle.strokeWidth = 4
        circle.map = mapView
    }

}

//extension ViewController: GMSMapViewDelegate {
//
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        print("willmove \(gesture)")
//    }
//    
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        print("Did change position: \(position.target.longitude)")
//    }
//    
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        print("Did tap at: (\(coordinate.latitude), \(coordinate.longitude))")
//    }
//}
