# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{easel_helpers}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Clayton"]
  s.date = %q{2009-05-07}
  s.description = %q{Fusionary Rails View Helpers}
  s.email = %q{joshua.clayton@gmail.com}
  s.extra_rdoc_files = ["lib/easel_helpers/helpers/date_helper.rb", "lib/easel_helpers/helpers/form_helper.rb", "lib/easel_helpers/helpers/grid_helper.rb", "lib/easel_helpers/helpers/link_helper.rb", "lib/easel_helpers/helpers/structure_helper.rb", "lib/easel_helpers/helpers/table_helper.rb", "lib/easel_helpers/helpers.rb", "lib/easel_helpers/rails_partial_caching.rb", "lib/easel_helpers.rb", "README.textile", "tasks/easel_helpers_tasks.rake"]
  s.files = ["easel_helpers.gemspec", "lib/easel_helpers/helpers/date_helper.rb", "lib/easel_helpers/helpers/form_helper.rb", "lib/easel_helpers/helpers/grid_helper.rb", "lib/easel_helpers/helpers/link_helper.rb", "lib/easel_helpers/helpers/structure_helper.rb", "lib/easel_helpers/helpers/table_helper.rb", "lib/easel_helpers/helpers.rb", "lib/easel_helpers/rails_partial_caching.rb", "lib/easel_helpers.rb", "Manifest", "MIT-LICENSE", "rails/init.rb", "Rakefile", "README.textile", "tasks/easel_helpers_tasks.rake", "test/date_helper_test.rb", "test/form_helper_test.rb", "test/grid_helper_test.rb", "test/link_helper_test.rb", "test/structure_helper_test.rb", "test/table_helper_test.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/fusionary/easel_helpers}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Easel_helpers", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{easel_helpers}
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Fusionary Rails View Helpers}
  s.test_files = ["test/date_helper_test.rb", "test/form_helper_test.rb", "test/grid_helper_test.rb", "test/link_helper_test.rb", "test/structure_helper_test.rb", "test/table_helper_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<actionview>, [">= 0", ">= 2.1.0"])
      s.add_development_dependency(%q<activesupport>, [">= 0", ">= 2.1.0"])
      s.add_development_dependency(%q<hpricot>, [">= 0", ">= 0.8.1"])
    else
      s.add_dependency(%q<actionview>, [">= 0", ">= 2.1.0"])
      s.add_dependency(%q<activesupport>, [">= 0", ">= 2.1.0"])
      s.add_dependency(%q<hpricot>, [">= 0", ">= 0.8.1"])
    end
  else
    s.add_dependency(%q<actionview>, [">= 0", ">= 2.1.0"])
    s.add_dependency(%q<activesupport>, [">= 0", ">= 2.1.0"])
    s.add_dependency(%q<hpricot>, [">= 0", ">= 0.8.1"])
  end
end
