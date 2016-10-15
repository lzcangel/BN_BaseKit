# MARK: converted automatically by spec.py. @hgy

Pod::Spec.new do |s|
	s.name = 'BN_BaseKit'
	s.version = '1.0.0'
	s.description = '框架'
	s.summary = 'BN_BaseKit'
	s.requires_arc = true
	s.ios.deployment_target = '7.0'
	s.source_files = 'CommonFiles_BaseCode/**/*.{h,m}'
	s.homepage = 'https://github.com/lzcangel/BN_BaseKit'
	s.source = https://github.com/lzcangel/BN_BaseKit.git
	s.license = 'MIT'
	s.resources = 'CommonFiles_BaseCode/**/*.{json,png,jpg,gif,js,xib}'

	s.dependency 'AFNetworking'
	s.dependency 'SDWebImage'
	s.dependency 'Masonry'
	s.dependency 'MBProgressHUD'
	s.dependency 'ReactiveCocoa'
	s.dependency 'SWTableViewCell'
	s.dependency 'HMSegmentedControl'
	s.dependency 'CTAssetsPickerController'
end
