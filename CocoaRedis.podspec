
Pod::Spec.new do |spec|

  spec.name         = "CocoaRedis"
  spec.version      = "1.0.0"
  spec.summary      = "iOS Redis."

  spec.description  = <<-DESC
  Bluetooth help quick update ota, it is help quick more device connect. so you use very smart!
                   DESC

  spec.homepage     = "https://github.com/QuickDevelopers/YModemLib"

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author       = { "ArdWang" => "278161009@qq.com" }

  spec.platform     = :ios, "9.0"

  spec.ios.deployment_target = "9.0"

  spec.source    = { :git => "https://github.com/QuickDevelopers/YModemLib.git", :tag => "#{spec.version}" }

  spec.source_files  = "YModemLib","YModemLib/YModem/*.{h,m,c}"
                 
  spec.frameworks = "Foundation","UIKit"

 

end