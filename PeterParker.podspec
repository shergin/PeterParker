Pod::Spec.new do |s|

  s.name = "PeterParker"
  s.version = "1.4.5"
  s.summary = "PeterParker"

  s.description  = <<-DESC
                   PeterParker
                   DESC

  s.homepage = "https://github.com/shergin/PeterParker"
  s.license = { :type => "MIT", :file => "LICENSE.txt" }
  s.author = { "Valentin Shergin" => "valentin@shergin.com" }
  s.social_media_url = "https://twitter.com/shergin"

  s.platform = :ios, "8.0"

  s.source = { :git => "https://github.com/shergin/PeterParker.git", :tag => "v#{s.version}" }
  s.source_files  = ["Sources/**/*.{swift,h}"]

  s.preserve_paths = "Sources/**/*"

  s.pod_target_xcconfig = {
    'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]' => '$(SRCROOT)/PeterParker/Sources/Modules/iphoneos',
    'SWIFT_INCLUDE_PATHS[sdk=iphonesimulator*]' => '$(SRCROOT)/PeterParker/Sources/Modules/iphonesimulator'
  }

  s.module_map = "Sources/PeterParker.modulemap"

  s.requires_arc = true

end
