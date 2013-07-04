Pod::Spec.new do |s|
  s.name         = "HFramework"
  s.version      = "0.0.1"
  s.homepage     = "https://github.com/guddns/HFramework"
  s.license      = 'Apache License 2.0'
  s.source       = { :git => "https://github.com/guddns/HFramework.git" }
  s.platform     = :ios, '5.0'
  s.source_files = 'HFramework/*.{h,m}'
  s.requires_arc = true
end