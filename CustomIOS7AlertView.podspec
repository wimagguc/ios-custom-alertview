Pod::Spec.new do |s|
  s.name         = "CustomIOS7AlertView"
  s.version      = "0.81"

  s.summary      = "A custom iOS7-like alert view."
  s.description  = <<-DESC
                    The addSubview is not available in UIAlertView in iOS7 any more. The view hierarchy for this class is 
                    private and must not be modified.

                    As a solution, this class creates an iOS7-style dialog which you can extend with any UIViews or buttons. 
                    The animations and the looks are copied too and no images or other resources are needed.
                   DESC

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.homepage     = "http://github.com/wimagguc/ios-custom-alertview/wiki"
  s.author       = "Richard Dancsi"

  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/wimagguc/ios-custom-alertview.git" }
  s.source_files = 'CustomIOS7AlertView/CustomIOS7AlertView/View/**/*.{h,m}'
  s.requires_arc = true
end
