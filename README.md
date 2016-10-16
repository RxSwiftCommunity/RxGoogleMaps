# RxGoogleMaps

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
    .drive(onNext: { 
        print("Did change camera position: (\($0.target.latitude), \($0.target.longitude))")
    })
    .addDisposableTo(disposeBag)

// Marker tapped

mapView.rx.didTapMarker.asDriver()
    .drive(onNext: {
        print("Did tap marker: \($0.title ?? "") (\($0.position.latitude), \($0.position.longitude))")
    })
    .addDisposableTo(disposeBag)

// Update marker icon without storing selection status

let s0 = mapView.rx.selectedMarker.asObservable()
let s1 = s0.skip(1)

Observable.zip(s0, s1) { $0 }
    .subscribe(onNext: { (prev, cur) in
        if let marker = prev {
            marker.icon = #imageLiteral(resourceName: "marker_normal")
        }
        if let marker = cur {
            marker.icon = #imageLiteral(resourceName: "marker_selected")
        }
    })
    .addDisposableTo(disposeBag)
                
```

### Binding properties
```Swift
// Properties

button.rx.tap
    .map { false }
    .bindTo(mapView.rx.trafficEnabled.asObserver())
    .addDisposableTo(disposeBag)

// Camera animations

button.rx.tap
    .map { 14 }
    .bindTo(mapView.rx.zoomToAnimate)
    .addDisposableTo(disposeBag)
            
button.rx.tap
    .map { GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 8, bearing: 10, viewingAngle: 30) }
    .bindTo(mapView.rx.cameraToAnimate)
    .addDisposableTo(disposeBag)
    
// Selected marker

button.rx.tap
    .map { myMarker }
    .bindTo(mapView.rx.selectedMarker.asObserver())
    .addDisposableTo(disposeBag)
    
// GMSMarker or GMSOverlay properties

button.rx.tap
    .map{ 180.0 }
    .bindTo(marker.rx.rotation.asObserver())
    .addDisposableTo(disposeBag)

button.rx.tap
    .map{ UIColor.red }
    .bindTo(circle.rx.fillColor.asObserver())
    .addDisposableTo(disposeBag)
    
```

## Installation

### CocoaPods

Add to `Podfile`:

```
pod 'GoogleMaps', '~> 2.1.0'
pod 'RxGoogleMaps', :git => 'https://github.com/inkyfox/RxGoogleMaps.git'
```

and 

**Add ``Pods/RxGoogleMaps/RxGoogleMapsBridge.swift`` to your app target in your project.**

## Requirements

RxGoogleMaps requires Swift 3.0 and dedicated versions of RxSwift 3.0.0-beta.2

## License

MIT
