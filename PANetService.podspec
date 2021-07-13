#
# Be sure to run `pod lib lint PADSBridge.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PANetService"
  s.version          = "1.0.2"
  s.summary          = "AFNetwork 网络请求封装"
  s.homepage         = "http://code.paic.com.cn/#/repo/iosmodules/panetservice"
  s.author           = { "cmb" => "zhutianwei224@pingan.com.cn" }
  s.license          = {
    :type => 'Copyright',
    :text => <<-LICENSE
    © 2021-2021 pingan. All rights reserved.
    LICENSE
  }
  s.platform         = :ios, '9.0'
  s.requires_arc     = true
  s.source           = { :git => "http://code.paic.com.cn/iosmodules/panetmanage.git" }
  s.dependency  'AFNetworking'
  s.dependency  'MBProgressHUD','=0.8'
  s.dependency  'Reachability'
  s.dependency  'JUJsonModel'

  #s.dependency  'PADSBridge/Base'
  s.source_files = 'Source/*.{h,m}'

  s.subspec 'Public' do |n|
     n.source_files = 'Source/Public/*.{h,m}'
   end
   
  
 end

