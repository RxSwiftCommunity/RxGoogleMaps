platform :ios, '14.0'
source 'https://github.com/CocoaPods/Specs.git'

target 'Example' do
    pod 'RxGoogleMaps', :path => './'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '5.0'
        config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'NO'
    end
  end
end
