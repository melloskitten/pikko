#
# Be sure to run `pod lib lint Pikko.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Pikko'
  s.version          = '0.1.0'
  s.summary          = 'pikko - iOS color picker made with ❤️'
  s.swift_version = '4.0'


  s.description      = <<-DESC
  Created due to the lack of pretty & functionally useful color picker libraries for iOS. Feel free to use, modify and improve. ✌️
                       DESC

  s.homepage         = 'https://github.com/melloskitten/pikko/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sandra' => 'melloskitten@googlemail.com', 'Johannes' => 'mail@johannesrohwer.com' }
  s.source           = { :git => 'https://github.com/melloskitten/pikko.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Pikko/Classes/**/*'
end
