require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-sinocare"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/zackfly/react-native-sinocare.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm}"
  s.vendored_frameworks = 'ios/Vendors/SinoDetection.framework'
  s.framework = 'SinoDetection'

  s.dependency "React-Core"
  s.dependency 'AFNetworking', '4.0.1'
  s.dependency 'LKDBHelper', '2.5.3'
  s.dependency 'ProtocolBuffers', '1.9.11'
end
