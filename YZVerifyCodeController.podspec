#
#  Be sure to run `pod spec lint YZTagList.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "YZVerifyCodeController"
  s.version      = "1.2.0"
  s.summary      = "验证框"
  s.homepage     = "https://github.com/iThinkerYZ"
  s.license      = "MIT"
  s.author             = { "iThinkerYZ" => "690423479@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/iThinkerYZ/YZVerifyCodeController.git", :tag => "1.2.0" }

  s.source_files  =  "YZVerifyCodeController/YZVerifyCodeController/YZVerifyCodeController/*.{h,m}"

  s.framework  = "UIKit"
  s.resource     = 'YZVerifyCodeController/YZVerifyCodeController/YZVerifyCodeController/YZVerifyCodeController.bundle'



end
