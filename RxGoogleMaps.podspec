Pod::Spec.new do |s|
  s.name             = "RxGoogleMaps"
  s.version          = "2.1.1"
  s.summary          = "RxSwift reactive wrapper for GoogleMaps SDK."
  s.description      = <<-DESC
    RxSwift reactive wrapper for GoogleMaps SDK. 
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

mapView.rx.didChangePosition.asDriver()
    .drive(onNext: { print("Did change camera position: \($0)") })
    .addDisposableTo(disposeBag)

// Marker tapped

mapView.rx.didTapMarker.asDriver()
    .drive(onNext: { print("Did tap marker: \($0)") })
    .addDisposableTo(disposeBag)

// Update marker icon without storing selection status

let s0 = mapView.rx.selectedMarker.asObservable()
let s1 = s0.skip(1)

Observable.zip(s0, s1) { $0 }
    .subscribe(onNext: { (prev, cur) in
        if let marker = prev { marker.icon = #imageLiteral(resourceName: "marker_normal") }
        if let marker = cur { marker.icon = #imageLiteral(resourceName: "marker_selected") }
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

## Installation

Because GoogleMaps SDK include static binaries, it's hard to find a nice solution to make a *straight-forward* Cocoapods framework if it uses GoogleMaps SDK. So I decided ``RxGoogleMaps`` not to use ``GoogleMaps`` directly and to provide a *bridging* swift file which connects ``GoogleMaps`` and ``RxGoogleMaps`` instead.

1. Add to `Podfile`:

    ```
    pod 'GoogleMaps'
    pod 'RxGoogleMaps'
  ```
2. Add **``Pods/RxGoogleMaps/RxGoogleMapsBridge.swift`` file to your app target** in your Xcode project manually. (Once at first installation)

## Requirements

RxGoogleMaps requires Swift 3.0 and dedicated versions of RxSwift 3.0.0-beta.2 (Xcode8+ and iOS8+)

## License

MIT
                        DESC
  s.homepage         = "https://github.com/RxSwiftCommunity/RxGoogleMaps"
  s.license          = 'MIT'
  s.author           = { "Yongha Yoo" => "inkyfox@oo-v.com" }
  s.source           = { :git => "https://github.com/RxSwiftCommunity/RxGoogleMaps.git", :tag => s.version.to_s }

  s.requires_arc          = true

  s.ios.deployment_target = '8.0'

  s.source_files          = 'Sources/*.swift'
  s.preserve_paths        = 'RxGoogleMapsBridge.swift'

  s.dependency 'RxSwift', '~> 3.0.0-beta.2'
  s.dependency 'RxCocoa', '~> 3.0.0-beta.2'

  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0'
  }

end
