platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'

target 'Example' do
    pod 'RxGoogleMaps', :path => './'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
        #config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
