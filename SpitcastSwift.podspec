Pod::Spec.new do |s|
  s.name             = 'SpitcastSwift'
  s.version          = '0.0.10'
  s.summary          = 'Swift wrapper for the Spitcast API.'
  s.description      = <<-DESC
This unofficial library is meant to expose most of the core forecasting endpoints of the open Spitcast API in Swift.
                       DESC
  s.homepage         = 'https://github.com/daniel-legler/SpitcastSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Legler' => 'daniel.legler@gmail.com' }
  s.source           = { :git => 'https://github.com/daniel-legler/SpitcastSwift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_dlegler'
  s.ios.deployment_target = '10.0'
  s.source_files = 'SpitcastSwift/Classes/**/*'
  s.swift_version = '5.0'
end
