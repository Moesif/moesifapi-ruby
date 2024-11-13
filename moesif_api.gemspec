Gem::Specification.new do |s|
  s.name = 'moesif_api'
  s.version = '2.1.1'
  s.summary = 'moesif_api'
  s.description = 'Collection/Data Ingestion API'
  s.authors = ['Moesif, Inc', 'Derric Gilling']
  s.email = 'derric@moesif.com'
  s.homepage = 'https://moesif.com'
  s.license = 'Apache-2.0'
  s.add_development_dependency('test-unit', '~> 3.5', '>= 3.5.0')
  s.add_dependency('faraday', '>= 1.0', '< 3.0')
  s.add_dependency('faraday-net_http_persistent', '< 3.0')
  s.add_dependency('faraday-retry', '< 3.0')
  s.add_dependency('json_mapper', '~> 0')
  s.add_dependency('net-http-persistent', '~> 4')
  s.required_ruby_version = '>= 2.6'
  s.files = Dir['{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*']
  s.require_paths = ['lib']
end
