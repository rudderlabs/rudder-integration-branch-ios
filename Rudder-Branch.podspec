require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

branch_sdk_version = '~> 3.0.0'
rudder_sdk_version = '~> 1.18'
deployment_target = '12.0'
branch_sdk = 'BranchSDK'

Pod::Spec.new do |s|
  s.name             = 'Rudder-Branch'
  s.version          = package['version']
  s.summary          = 'Privacy and Security focused Segment-alternative. BranchIO Native SDK integration support.'

  s.description      = <<-DESC
  Rudder is a platform for collecting, storing and routing customer event data to dozens of tools. Rudder is open-source, can run in your cloud environment (AWS, GCP, Azure or even your data-centre) and provides a powerful transformation framework to process your event data on the fly.
                       DESC
  s.homepage         = 'https://github.com/rudderlabs/rudder-integration-branch-ios'
  s.license          = { :type => "Apache", :file => "LICENSE" }
  s.author           = { 'RudderStack' => 'arnab@rudderlabs.com' }
  s.source           = { :git => 'https://github.com/rudderlabs/rudder-integration-branch-ios.git', :tag => "v#{s.version}" }
  s.platform         = :ios, "12.0"

  s.ios.deployment_target = '12.0'

  s.source_files = 'Rudder-Branch/Classes/**/*'
  
  if defined?($BranchSDKVersion)
    branch_sdk_version = $BranchSDKVersion
    Pod::UI.puts "#{s.name}: Using user specified Branch SDK version '#{branch_sdk_version}'"
  else
    Pod::UI.puts "#{s.name}: Using default Branch SDK version '#{branch_sdk_version}'"
  end
  
  if defined?($RudderSDKVersion)
    Pod::UI.puts "#{s.name}: Using user specified Rudder SDK version '#{$RudderSDKVersion}'"
    rudder_sdk_version = $RudderSDKVersion
  else
    Pod::UI.puts "#{s.name}: Using default Rudder SDK version '#{rudder_sdk_version}'"
  end

  s.dependency 'Rudder', rudder_sdk_version
  s.dependency branch_sdk, branch_sdk_version
end
