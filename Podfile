use_frameworks!

target 'SimpleReactive_Example' do
  pod 'SimpleReactive', :path => '.'

  target 'SimpleReactive_Tests' do
    inherit! :search_paths

    
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
end
