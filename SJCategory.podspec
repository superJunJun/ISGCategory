
Pod::Spec.new do |s|
  s.name             = 'SJCategory'
  s.version          = '1.2.6'
  s.summary          = '常用类别，常用工具类，HUD，地理坐标转换，DES，介绍页'
  s.ios.deployment_target = '8.0'
  s.homepage         = 'https://github.com/superJunJun/ISGCategory'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '15934874308@163.com' => 'lijun@ishanggang.com' }
  s.source           = { :git => 'https://github.com/superJunJun/ISGCategory.git', :tag => s.version, :submodules => true }

    s.resource_bundles = {
    'SJCategory' => ['SJCategory/Assets/*.png']
    }
#s.source_files  = "SJCategory/Classes/**/*.{h,m}"

    s.subspec 'Category' do |ss|
    ss.source_files = 'SJCategory/Classes/Category/**/*'
    end

    s.subspec 'BOTool' do |ss|
    ss.source_files = 'SJCategory/Classes/BOTool/**/*'
    end

    s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics', 'MBProgressHUD', '~> 1.1.0'
end
