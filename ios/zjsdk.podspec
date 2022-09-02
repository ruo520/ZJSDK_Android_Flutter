#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'zjsdk'
  s.version          = '2.4.8'
  s.summary          = 'Flutter plugin for launching a URL.'
  s.description      = <<-DESC
A Flutter plugin for making the underlying platform (Android or iOS) launch a URL.
                       DESC
  s.homepage         = 'https://github.com/macroswang/ZJSDK_Android_Flutter'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'XReddot Dev Team' => 'macroswang@gmail.com' }
  s.source           = { :http => 'https://github.com/macroswang/ZJSDK_Android_Flutter' }
  s.documentation_url = 'https://github.com/macroswang/ZJSDK_Android_Flutter'
  # s.source_files = 'Classes/**/*'
  # s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  
  s.platform = :ios, '9.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end

