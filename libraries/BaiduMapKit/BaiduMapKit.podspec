
Pod::Spec.new do |s|
  s.name             = "BaiduMapKit"
  s.version          = "3.3.1"
  s.summary          = "BaiduMapKit.podspec For transfar ehuodi company 2.0"
  s.description      = <<-DESC
                       It is a BaiduMapKit.podspec module used on iOS, which implement by Objective-C.
                       DESC
  s.author           = "lhs"
  s.source           = { :git => "../libraries/BaiduMapKit" }
  s.homepage         = "www.baidu.com"
  s.license          = "MIT"

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '6.0'
  s.ios.compiler_flags = '-Wno-documentation'


  s.libraries = ['stdc++.6', 'sqlite3.0']
  s.frameworks   =  "CoreLocation", "QuartzCore", "OpenGLES", "SystemConfiguration", "CoreGraphics", "Security", "CoreTelephony"

  s.vendored_frameworks = 'BaiduMap_IOSSDK/BaiduMapAPI_Base.framework', 'BaiduMap_IOSSDK/BaiduMapAPI_Location.framework', 'BaiduMap_IOSSDK/BaiduMapAPI_Map.framework', 'BaiduMap_IOSSDK/BaiduMapAPI_Search.framework', 'BaiduMap_IOSSDK/BaiduMapAPI_Utils.framework'
  s.vendored_libraries = "BaiduMap_IOSSDK/thirdlibs/*.a"

  s.resources = ['BaiduMap_IOSSDK/BaiduMapAPI_Map.framework/Resources/mapapi.bundle']
end
