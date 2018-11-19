# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'AppiumSwiftClient' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'SwiftLint', '~> 0.28'

  target 'AppiumSwiftClientUnitTests' do
    inherit! :search_paths
    pod 'Mockingjay', '~> 2.0'
  end

  target 'AppiumFuncTests' do
    inherit! :search_paths
    pod 'Mockingjay', '~> 2.0'
  end
end

