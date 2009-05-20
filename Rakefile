require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'echoe'

Echoe.new("easel_helpers", "0.2.3") do |p|
  p.description = "Fusionary Rails View Helpers"
  p.url = "http://github.com/fusionary/easel_helpers"
  p.author = "Joshua Clayton"
  p.email = "joshua.clayton@gmail.com"
  p.ignore_pattern = ["tmp/*"]
  p.development_dependencies = ["actionview >= 2.1.0", "activesupport >= 2.1.0", "hpricot >= 0.8.1"]
end

desc 'Test the easel_helpers plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the easel_helpers plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Easel-helpers'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
