$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

require 'require_all'

task default: :test

task :test do
  require_relative 'test/helper.rb'
  require_rel 'test/**/*_spec.rb'
end
