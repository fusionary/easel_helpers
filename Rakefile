require 'rake'
require 'rake/testtask'
require 'rcov/rcovtask'
require 'echoe'

Echoe.new("easel_helpers", "0.2.17") do |p|
  p.description = "Fusionary Rails View Helpers"
  p.url = "http://github.com/fusionary/easel_helpers"
  p.author = "Joshua Clayton"
  p.email = "joshua.clayton@gmail.com"
  p.ignore_pattern = ["tmp/*"]
  p.development_dependencies = ["actionview >= 2.1.0", "activesupport >= 2.1.0", "hpricot >= 0.8.1"]
end

Rcov::RcovTask.new("rcov:current") do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end
