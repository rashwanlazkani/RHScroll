Pod::Spec.new do |s|
    s.name             = 'RHScroll'
    s.version          = '1.0'
    s.summary          = 'With RHScroll you have a horizontal ScrollView with built in animations and notifications for tap and longPress gestures.'
    s.swift_version    = '4.2'
    
    s.description      = <<-DESC
    RHScroll  is a ScrollView similar to several famous apps out on the App Store. It creates in a simple way a horizontal ScrollView which can be used for several different purposes. You´re able to choose the size of the ScrollView, size of the items, the data and the positioning of everything. It has built in animations for tap and longPress.
    
    DESC
    
    s.homepage         = 'https://github.com/rashwanlazkani/RHScroll'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'rashwanlazkani' => 'rashwan87@gmail.com' }
    s.source           = { :git => 'https://github.com/rashwanlazkani/RHScroll.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '10.0'
    
    s.source_files = 'RHScroll/Classes/*.swift'
    
    # s.resource_bundles = {
    #   'RHScroll' => ['RHScroll/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
