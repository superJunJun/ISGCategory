#
# Be sure to run `pod lib lint SJCategory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SJCategory'
  s.version          = '1.2.2'
  s.summary          = '常用类别，常用工具类，HUD，地理坐标转换，DES，介绍页'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/superJunJun/ISGCategory'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '15934874308@163.com' => 'lijun@ishanggang.com' }
  s.source           = { :git => 'https://github.com/superJunJun/ISGCategory.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

    s.public_header_files = 'SJCategory/CommonMacro.h'
    s.source_files = 'SJCategory/CommonMacro.h'

  # s.resource_bundles = {
  #   'SJCategory' => ['SJCategory/Assets/*.png']
  # }

    s.subspec 'BOAssistor' do |ss|
    ss.source_files = 'SJCategory/BOAssistor.{h,m}'
    ss.public_header_files = 'SJCategory/BOAssistor.h'
    end

    s.subspec 'BOCoordinate' do |ss|
    ss.source_files = 'SJCategory/BOCoordinateTransformation.{h,m}'
    ss.public_header_files = 'SJCategory/BOCoordinateTransformation.h'
    end

    s.subspec 'BOHUDManager' do |ss|
    ss.source_files = 'SJCategory/BOHUDManager.{h,m}','SJCategory/40x-{Cancel,Check}mark@2x.{png}'
    ss.public_header_files = 'SJCategory/BOHUDManager.h'
    end

    s.subspec 'BONoticeBar' do |ss|
    ss.source_files = 'SJCategory/BONoticeBar.{h,m}'
    ss.public_header_files = 'SJCategory/BONoticeBar.h'
    end

    s.subspec 'BOTimeStamp' do |ss|
    ss.source_files = 'SJCategory/BOTimeStampAssistor.{h,m}'
    ss.public_header_files = 'SJCategory/BOTimeStampAssistor.h'
    end

    s.subspec 'Category' do |ss|
    ss.source_files = 'SJCategory/NSObject+SXRuntime.{h,m}',
    'SJCategory/NSString+MD5Addition.{h,m}',
    'SJCategory/UIButton+ImageTitleSpacing.{h,m}',
    'SJCategory/UIColor+Hex.{h,m}',
    'SJCategory/UIImage+Dashed.{h,m}',
    'SJCategory/UINavigation+SXFixSpace.{h,m}',
    'SJCategory/UINavigationController+SXFullScreen.{h,m}',
    'SJCategory/UIViewExt.{h,m}'

    ss.public_header_files = 'SJCategory/NSObject+SXRuntime.h',
    'SJCategory/NSString+MD5Addition.h',
    'SJCategory/UIButton+ImageTitleSpacing.h',
    'SJCategory/UIColor+Hex.h',
    'SJCategory/UIImage+Dashed.h',
    'SJCategory/UINavigation+SXFixSpace.h',
    'SJCategory/UINavigationController+SXFullScreen.h',
    'SJCategory/UIViewExt.h'
    end

    s.subspec 'DESUtil' do |ss|
    ss.source_files = 'SJCategory/DESUtil.{h,m}'
    ss.public_header_files = 'SJCategory/DESUtil.h'
    end

    s.subspec 'GTMBase64' do |ss|
    ss.source_files = 'SJCategory/GTMBase64.{h,m}','SJCategory/GTMDefines.h'
    ss.public_header_files = 'SJCategory/GTMBase64.h','SJCategory/GTMDefines.h'
    end

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'
  s.dependency 'MBProgressHUD', '~> 1.1.0'
end
