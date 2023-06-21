post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end

# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'FontainApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'

  # Pods for FontainApp

pod 'FirebaseDatabase'
pod 'FirebaseFirestoreSwift'
pod 'FirebaseAuth'
pod 'FirebaseFirestore'
pod 'FirebaseStorage'
pod 'FirebaseAuth'
pod 'FlagPhoneNumber'
pod 'Kingfisher'
pod 'Cloudipsp'
pod 'Firebase'
pod 'CountryPickerSwift', '1.8'
pod 'GoogleMaps', '8.0.0'

end
