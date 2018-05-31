
Pod::Spec.new do |s|
  s.name             = 'SJCategory'
  s.version          = '1.2.5'
  s.summary          = '常用类别，常用工具类，HUD，地理坐标转换，DES，介绍页'
  s.ios.deployment_target = '8.0'
  s.homepage         = 'https://github.com/superJunJun/ISGCategory'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '15934874308@163.com' => 'lijun@ishanggang.com' }
  s.source           = { :git => 'https://github.com/superJunJun/ISGCategory.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'

  s.default_subspecs = "BOAssistor", "BOCoordinate", "BOHUDManager", "BONoticeBar", "BOTimeStamp", "Category", "DESUtil", "GTMBase64"

  s.resource_bundles = {
    'SJCategory' => ['SJCategory/Assets/*.png']
  }

    s.subspec 'BOAssistor' do |ss|
        ss.source_files = 'SJCategory/Classes/BOAssistor/*.{h,m}'
    end

    s.subspec 'BOCoordinate' do |ss|
    ss.source_files = 'SJCategory/Classes/BOCoordinate/*.{h,m}'
    end

    s.subspec 'BOHUDManager' do |ss|
    ss.source_files = 'SJCategory/Classes/BOHUDManager/*.{h,m}','SJCategory/Classes/BOHUDManager/40x-{Cancel,Check}mark@2x.{png}'
    end

    s.subspec 'BONoticeBar' do |ss|
    ss.source_files = 'SJCategory/Classes/BONoticeBar/*.{h,m}'
    end

    s.subspec 'BOTimeStamp' do |ss|
    ss.source_files = 'SJCategory/Classes/BOTimeStamp/*.{h,m}'
    ss.public_header_files = 'SJCategory/BOTimeStampAssistor.h'
    end

    s.subspec 'Category' do |ss|
    ss.source_files = 'SJCategory/Classes/Category/*.{h,m}'
    end

    s.subspec 'DESUtil' do |ss|
    ss.source_files = 'SJCategory/Classes/DESUtil/*.{h,m}'
    end

    s.subspec 'GTMBase64' do |ss|
    ss.source_files = 'SJCategory/Classes/GTMBase64/*.{h,m}','SJCategory/Classes/GTMBase64/*.h'
    end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'
  s.dependency 'MBProgressHUD', '~> 1.1.0'
end
