

Pod::Spec.new do |spec|


  spec.name         = "CalendarMonth"
  spec.version      = "0.0.1"
  spec.summary      = "Simple calendar with a choice of period."

  spec.description  = <<-DESC
This CocoaPods library helps you selected date.
                   DESC

  spec.homepage     = "http://github.com/Hudihka/CalendarMonth"
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.authors      = { "Константин Худышка" => "k.iroshnikov@itmegastar.com" }


  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5.0"

  spec.source       = { :git => "http://github.com/Hudihka/CalendarMonth.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m}"

end
