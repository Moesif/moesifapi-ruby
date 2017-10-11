Gem::Specification.new do |s|
  s.name = 'moesif_api'
  s.version = '1.2.0'
  s.summary = 'moesif_api'
  s.description = 'Collection/Data Ingestion API'
  s.authors = ['Moesif, Inc', 'Derric Gilling']
  s.email = 'derric@moesif.com'
  s.homepage = 'https://moesif.com'
  s.license = 'Apache-2.0'
  s.add_dependency('test-unit', '~> 3.1.5')
  s.add_dependency('unirest', '~> 1.1.2')
  s.add_dependency('json_mapper', '~> 0.2.1')
  s.required_ruby_version = '~> 2.0'
  s.files = Dir['{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*']
  s.require_paths = ['lib']
end
