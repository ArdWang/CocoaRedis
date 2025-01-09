
Pod::Spec.new do |spec|

  spec.name         = "CocoaRedis"
  spec.version      = "1.0.2"
  spec.summary      = "iOS Redis."

  spec.description  = <<-DESC
  Redis help connect. so you use very smart!
                   DESC

  spec.homepage     = "https://github.com/ArdWang/CocoaRedis"

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author       = { "ArdWang" => "278161009@qq.com" }

  spec.platform     = :ios, "11.0"

  spec.ios.deployment_target = "11.0"

  spec.source    = { :git => "https://github.com/ArdWang/CocoaRedis.git", :tag => "#{spec.version}" }

  spec.source_files  = "CocoaRedis","CocoaRedis/CocoaRedis/**/*.{h,m,c}"
                 
  spec.frameworks = "Foundation","UIKit"

 

end