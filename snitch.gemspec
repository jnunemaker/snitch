Gem::Specification.new do |s|
  s.name = %q{snitch}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Nunemaker"]
  s.date = %q{2008-10-25}
  s.default_executable = %q{snitch}
  s.description = %q{Drop dead easy subversion commit notifications.}
  s.email = ["nunemaker@gmail.com"]
  s.executables = ["snitch"]
  s.extra_rdoc_files = ["CHANGELOG.txt", "History.txt", "Manifest.txt", "PostInstall.txt", "README.txt", "TODO.txt"]
  s.files = ["CHANGELOG.txt", "History.txt", "MIT-LICENSE", "Manifest.txt", "PostInstall.txt", "README.txt", "Rakefile", "TODO.txt", "bin/snitch", "config/hoe.rb", "config/requirements.rb", "lib/snitch.rb", "lib/snitch/config.rb", "lib/snitch/gitcommit.rb", "lib/snitch/message.rb", "lib/snitch/revision.rb", "lib/snitch/revisions/git.rb", "lib/snitch/revisions/subversion.rb", "lib/snitch/service.rb", "lib/snitch/services/campfire.rb", "lib/snitch/services/echo.rb", "lib/snitch/services/email.rb", "lib/snitch/services/twitter.rb", "lib/snitch/version.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "snitch.gemspec", "tasks/deployment.rake", "tasks/environment.rake", "tasks/website.rake", "test/snitch_config", "test/test_helper.rb", "test/unit/revisions/git_test.rb", "test/unit/revisions/subversion_test.rb", "test/unit/service_test.rb", "test/unit/services/campfire_test.rb", "test/unit/services/echo_test.rb", "test/unit/services/email_test.rb", "test/unit/services/twitter_test.rb", "test/unit/snitch_test.rb", "website/css/common.css", "website/images/campfire.gif", "website/images/twitter.gif", "website/index.html"]
  s.has_rdoc = true
  s.homepage = %q{http://snitch.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{snitch}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Drop dead easy subversion commit notifications.}
  s.test_files = ["test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<activesupport>, [">= 1.3.1"])
      s.add_runtime_dependency(%q<mojombo-grit>, [">= 0.9.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 1.3.1"])
      s.add_dependency(%q<mojombo-grit>, [">= 0.9.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 1.3.1"])
    s.add_dependency(%q<mojombo-grit>, [">= 0.9.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end