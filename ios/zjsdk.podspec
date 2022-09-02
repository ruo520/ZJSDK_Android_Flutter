#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'zjsdk'
  s.version          = '2.4.8'
  s.summary          = 'No-op implementation of url_launcher_web web plugin to avoid build issues on iOS'
  s.description      = <<-DESC
temp fake url_launcher_web plugin
                       DESC
  s.homepage         = 'https://github.com/macroswang/ZJSDK_Android_Flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'XREDDOT Team' => 'macroswang@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '9.0'
end