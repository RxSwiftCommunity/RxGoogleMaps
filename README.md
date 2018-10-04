# RxGoogleMaps
[![CircleCI](https://img.shields.io/circleci/project/github/RxSwiftCommunity/RxGoogleMaps/master.svg)](https://circleci.com/gh/RxSwiftCommunity/RxGoogleMaps/tree/master)
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/RxGoogleMaps.svg?style=flat)](http://cocoapods.org/pods/RxGoogleMaps)
[![License](https://img.shields.io/cocoapods/l/RxGoogleMaps.svg?style=flat)](http://cocoapods.org/pods/RxGoogleMaps)
[![Platform](https://img.shields.io/cocoapods/p/RxGoogleMaps.svg?style=flat)](http://cocoapods.org/pods/RxGoogleMaps)


RxGoogleMaps is a [RxSwift](https://github.com/ReactiveX/RxSwift) wrapper for [GoogleMaps](https://developers.google.com/maps/documentation/ios-sdk/).

## Example Usages

### Setup GoogleMaps
```swift
// Setup API Key
GMSServices.provideAPIKey("Your-API-Key")
```


```swift
// Setup GMSMapview from Interface Builder
@IBOutlet weak var mapView: GMSMapView!
```
or
```swift
// Setup GMSMapview
let mapView = GMSMapView(frame: self.view.bounds)
self.view.addSubview(mapView)
```

### Observing properties
```swift
// Camera position

mapView.rx.didChange.asDriver()
    .drive(onNext: { print("Did change position: \($0)") })
    .disposed(by: disposeBag)

// Marker tapped

mapView.rx.didTapAt.asDriver()
    .drive(onNext: { print("Did tap at coordinate: \($0)") })
    .disposed(by: disposeBag)

// Location update

mapView.rx.myLocation
    .subscribe(onNext: { location in
        if let l = location {
            print("My location: (\(l.coordinate.latitude), \(l.coordinate.longitude))")
        } else {
            print("My location: nil")
        }
    })
    .disposed(by: disposeBag)

```

### Binding properties
```Swift
// Properties

button.rx.tap
    .map { false }
    .bind(to: mapView.rx.trafficEnabled.asObserver())
    .disposed(by: disposeBag)

// Camera animations

button.rx.tap
    .map { 14 }
    .bind(to: mapView.rx.zoomToAnimate)
    .disposed(by: disposeBag)

button.rx.tap
    .map { GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 8, bearing: 10, viewingAngle: 30) }
    .bind(to: mapView.rx.cameraToAnimate)
    .disposed(by: disposeBag)

// Selected marker

button.rx.tap
    .map { myMarker }
    .bind(to: mapView.rx.selectedMarker.asObserver())
    .disposed(by: disposeBag)

// GMSMarker or GMSOverlay properties

button.rx.tap
    .map{ 180.0 }
    .bind(to: marker.rx.rotation.asObserver())
    .disposed(by: disposeBag)

button.rx.tap
    .map{ UIColor.red }
    .bind(to: circle.rx.fillColor.asObserver())
    .disposed(by: disposeBag)

```

### Delegates which have a return value
```Swift
// func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool

mapView.rx.handleTapMarker { false }

// func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView?

mapView.rx.handleMarkerInfoWindow { marker in
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 60))
    label.textAlignment = .center
    label.textColor = UIColor.brown
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.backgroundColor = UIColor.yellow
    label.text = marker.title
    return label
}

```

*Note:* More examples can be found at the example project from this repo!.

## Installation

### CocoaPods

  *Note:* Due to the fact Google Maps is delivered as a static library, you must have CocoaPods 1.4.0 installed to install this library.


- Add to your `Podfile`:

```ruby
pod 'RxGoogleMaps'
```

Than run `pod install`, and you should be good to go!

## Example Project

1. Get your own API Key a key at https://developers.google.com/maps/documentation/ios-sdk/
2. Open the example project and set your API Key in AppDelegate

## Requirements

- Swift 4.2
- [RxSwift](https://github.com/ReactiveX/RxSwift) >= 4.3
- [RxCocoa](https://github.com/ReactiveX/RxSwift) >= 4.3

## License

MIT
