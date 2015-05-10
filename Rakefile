require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.init

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # no rspec available
end