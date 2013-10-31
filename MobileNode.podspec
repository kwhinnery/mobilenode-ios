Pod::Spec.new do |s|

  s.name         = "MobileNode"
  s.version      = "0.0.1"
  s.summary      = "A node.js-like runtime environment for iOS apps"

  s.description  = <<-DESC
                  MobileNode allows iOS developers to incorporate node.js
                  JavaScript programs into their native apps.  This allows 
                  JavaScript to drive native APIs for everything from games
                  to native UIKit apps.
                   DESC

  s.homepage     = "https://github.com/kwhinnery/MobileNodeiOS"
  s.license      = 'MIT'
  s.author       = { 
    "Kevin Whinnery" => "kevin.whinnery@gmail.com" 
  }
  s.platform     = :ios, '7.0'
  s.source       = { 
    :git => "https://github.com/kwhinnery/MobileNodeiOS.git", 
    :tag => "0.0.1" 
  }

  s.source_files  = 'MobileNode/MobileNode/Framework/*.{h,m}'
  s.resource = 'MobileNode/MobileNode/Framework/mnbootstrap.js'
  s.framework  = 'JavaScriptCore'
  s.requires_arc = true
  s.dependency 'socket.IO', '~> 0.4.0'

end
