platform :ios, '8.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

target 'Example' do
    pod 'GoogleMaps', '~> 2.1.0'
    pod 'RxGoogleMaps', :path => './'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
        #config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
