platform :ios, '8.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

target 'Example' do
    'RxSwift', '~> 4.0'
    'RxCocoa', '~> 4.0'
    'GoogleMaps', '~> 2.5.0'
    pod 'RxGoogleMaps', :path => './'
end

pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
        #config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
