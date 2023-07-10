Pod::Spec.new do |s|
  s.name             = "RxGoogleMaps"
  s.version          = "7.3.0"
  s.summary          = "RxSwift reactive wrapper for GoogleMaps SDK."
  s.homepage         = "https://github.com/RxSwiftCommunity/RxGoogleMaps"
  s.license          = 'MIT'
  s.author           = { "RxSwift Community" => "community@rxswift.org" }
  s.platform         = :ios, "14.0"
  s.source           = { :git => "https://github.com/RxSwiftCommunity/RxGoogleMaps.git", :tag => s.version.to_s }
  s.requires_arc          = true
  s.ios.deployment_target = '14.0'
  s.source_files          = 'Sources/RxGoogleMaps/*.swift'

  s.static_framework = true
  s.dependency 'RxSwift', '~> 6'
  s.dependency 'RxCocoa', '~> 6'
  s.dependency 'GoogleMaps', '~> 7.3.0'
end
