Gem::Specification.new do |s|
  s.name = 'redis-wrap'
  s.version = '0.0.0'

  # metadata
  s.license = 'MIT'
  s.date = '2014-10-15'
  s.summary = 'object-oriented redis'
  s.description = ''
  s.homepage = 'https://github.com/aj0strow/redis-wrap'
  s.authors = [ '@aj0strow' ]
  s.files = `git ls-files`.split(/\n/)
  puts s.files
  s.test_files = s.files.grep(/^test/)

  # dependencies
  s.add_runtime_dependency 'redis', '~> 3'
end
