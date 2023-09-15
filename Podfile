# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'e-Sushrut UP HMIS (DGME)' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for e-Sushrut UP HMIS (DGME)

  target 'e-Sushrut UP HMIS (DGME)Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'e-Sushrut UP HMIS (DGME)UITests' do
    # Pods for testing
  end
pod 'JitsiMeetSDK'
 #pod 'FSCalendar'
 pod 'iOSDropDown'
 pod 'Zoomy'
pod 'Charts'
  
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end
end