Pod::Spec.new do |s|
  s.name             = "RxGoogleMaps"
  s.version          = "2.1.3"
  s.summary          = "RxSwift reactive wrapper for GoogleMaps SDK."
  s.homepage         = "https://github.com/RxSwiftCommunity/RxGoogleMaps"
  s.license          = 'MIT'
  s.author           = { "Yongha Yoo" => "inkyfox@oo-v.com" }
  s.platform         = :ios, "8.0"
  s.source           = { :git => "https://github.com/RxSwiftCommunity/RxGoogleMaps.git", :tag => s.version.to_s }
  s.requires_arc          = true
  s.ios.deployment_target = '8.0'
  s.source_files          = 'Sources/*.swift'
  s.preserve_paths        = 'RxGoogleMapsBridge.swift'
  s.dependency 'RxSwift', '~> 3.0.0'
  s.dependency 'RxCocoa', '~> 3.0.0'
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0'
  }
end
