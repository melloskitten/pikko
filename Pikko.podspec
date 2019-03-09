#
Pod::Spec.new do |s|
  s.name             = 'Pikko'
  s.version          = '1.0.2'
  s.summary          = 'Pikko - iOS color picker made with ❤️'
  s.swift_version = '4.0'


  s.description      = <<-DESC
  Pikko is a simple and beautiful color picker for iOS. It's inspired by conventional color pickers from popular graphics tools such as _Photoshop_, _Paint Tool Sai_, _Procreate_ and many others. Pikko allows the selection of hue, saturation and brightness in a more pleasant way than boring sliders.
                       DESC

  s.homepage         = 'https://github.com/melloskitten/pikko/'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Sandra' => 'melloskitten@googlemail.com', 'Johannes' => 'mail@johannesrohwer.com' }
  s.source           = { :git => 'https://github.com/melloskitten/pikko.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Pikko/Classes/**/*'
end
