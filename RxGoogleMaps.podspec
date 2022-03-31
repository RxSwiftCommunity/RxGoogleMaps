Pod::Spec.new do |s|
  s.name             = "RxGoogleMaps"
  s.version          = "5.0.0"
  s.summary          = "RxSwift reactive wrapper for GoogleMaps SDK."
  s.homepage         = "https://github.com/RxSwiftCommunity/RxGoogleMaps"
  s.license          = 'MIT'
  s.author           = { "RxSwift Community" => "community@rxswift.org" }
  s.platform         = :ios, "9.0"
  s.source           = { :git => "https://github.com/RxSwiftCommunity/RxGoogleMaps.git", :tag => s.version.to_s }
  s.requires_arc          = true
  s.ios.deployment_target = '9.0'
  s.source_files          = 'Sources/*.swift'

  s.static_framework = true
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'GoogleMaps', '~> 5'

end
