# MARK: converted automatically by spec.py. @hgy

Pod::Spec.new do |s|
	s.name = 'BN_BaseKit'
	s.version = 'master'
	s.description = '框架'
	s.summary = 'BN_BaseKit code'
	s.requires_arc = true
	s.ios.deployment_target = '8.0'
	s.source_files = 'CommonFiles_BaseCode/**/*.{h,m}'
	s.homepage = 'https://github.com/lzcangel/BN_BaseKit'
	s.source = { :git => 'https://github.com/lzcangel/BN_BaseKit.git', :branch => s.version, :submodules => true}
	s.license = 'MIT'
	s.resources = 'CommonFiles_BaseCode/**/*.{json,png,jpg,gif,js,xib}'
	s.authors  = { 'lzcangel' => '592097271@qq.com' }
	s.swift_version = '2.3'

	s.dependency 'AFNetworking'
	s.dependency 'SDWebImage'
	s.dependency 'Masonry'
	s.dependency 'MBProgressHUD'
	s.dependency 'ReactiveCocoa'
	s.dependency 'SWTableViewCell'
	s.dependency 'HMSegmentedControl'
	s.dependency 'CTAssetsPickerController'
end
