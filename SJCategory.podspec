
Pod::Spec.new do |s|
  s.name             = 'SJCategory'
  s.version          = '1.2.6'
  s.summary          = '常用类别，常用工具类，HUD，地理坐标转换，DES，介绍页'
  s.ios.deployment_target = '8.0'
  s.homepage         = 'https://github.com/superJunJun/ISGCategory'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '15934874308@163.com' => 'lijun@ishanggang.com' }
  s.source           = { :git => 'https://github.com/superJunJun/ISGCategory.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'

    s.source_files  = "SJCategory/Classes/**/*.{h,m}"

    s.resource_bundles = {
    'SJCategory' => ['SJCategory/Assets/*.png']
    }

    s.subspec 'Category' do |c|
    c.source_files = 'SJCategory/Classes/Category/**/*'
    end

    s.subspec 'BOTool' do |t|
    t.source_files = 'SJCategory/Classes/BOTool/**/*'
    t.dependency 'MBProgressHUD', '~> 1.1.0'
    end

    s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'
end
