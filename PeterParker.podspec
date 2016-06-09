Pod::Spec.new do |s|

  s.name = "PeterParker"
  s.version = "1.5.2"
  s.summary = "Beautiful wrapper around ugly Mac/BSD low-level network API. Written in Swift."

  s.description  = <<-DESC
    Beautiful wrapper around ugly Mac/BSD low-level network API. Written in Swift.
    DESC

  s.homepage = "https://github.com/shergin/PeterParker"
  s.license = { :type => "MIT", :file => "LICENSE.txt" }
  s.author = { "Valentin Shergin" => "https://twitter.com/shergin" }
  s.social_media_url = "https://twitter.com/shergin"

  s.platform = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.source = { :git => "https://github.com/shergin/PeterParker.git", :tag => "v#{s.version}" }
  s.source_files = ["PeterParker/*/*.swift"]
  
  s.requires_arc = true

end
