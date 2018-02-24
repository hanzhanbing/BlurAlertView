Pod::Spec.new do |s|
  s.name         = 'BlurAlertView'
  s.version      = '1.0.0'
  s.ios.deployment_target = '7.0'
  s.summary      = 'An example of BlurAlertView Function'
  s.homepage     = 'https://github.com/hanzhanbing/BlurAlertView'
  s.license  =  { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'hanzhanbing' => '1655661337@qq.com' }
  s.social_media_url   = 'http://weibo.com/3879141691'
  s.source       = { :git => 'https://github.com/hanzhanbing/BlurAlertView.git', :tag => s.version }
  s.public_header_files = 'BlurAlertView/*.h', 'BlurAlertView/**/*.h'
  s.source_files  = 'BlurAlertView/*.{h,m}', 'BlurAlertView/**/*.{h,m}'
  s.requires_arc = true
end
