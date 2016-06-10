Pod::Spec.new do |s|

  s.name = "PeterParker"
  s.version = "1.4.2"
  s.summary = "PeterParker"

  s.description  = <<-DESC
                   PeterParker
                   DESC

  s.homepage = "https://github.com/shergin/PeterParker"
  s.license = { :type => "MIT", :file => "LICENSE.txt" }
  s.author = { "Valentin Shergin" => "valentin@shergin.com" }
  s.social_media_url = "https://twitter.com/shergin"

  s.ios.platform = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.osx.platform = :osx, "10.10"
  s.osx.deployment_target = "10.10"

  s.source = { :git => "https://github.com/shergin/PeterParker.git", :tag => "v#{s.version}" }
  s.source_files  = ["Sources/**/*.{swift,h}"]

  s.preserve_paths = "Sources/**/*"

  s.pod_target_xcconfig = {
    'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]'         => '$(SRCROOT)/Sources/Modules/iphoneos',
    'SWIFT_INCLUDE_PATHS[sdk=iphonesimulator*]'  => '$(SRCROOT)/Sources/Modules/iphonesimulator'
  }

  s.module_map = "Sources/PeterParker.modulemap"

  s.requires_arc = true

end
