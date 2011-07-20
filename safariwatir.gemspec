# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{safariwatir}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Dave Hoover}]
  s.date = %q{2011-07-19}
  s.description = %q{WATIR stands for "Web Application Testing in Ruby".  See WATIR project for more information.  This is a Safari-version of the original IE-only WATIR.}
  s.email = %q{dave@obtiva.com}
  s.extra_rdoc_files = [%q{README.rdoc}, %q{lib/safariwatir.rb}, %q{lib/safariwatir/core_ext.rb}, %q{lib/safariwatir/element_attributes.rb}, %q{lib/safariwatir/locators.rb}, %q{lib/safariwatir/scripter.rb}, %q{lib/watir/exceptions.rb}]
  s.files = [%q{Gemfile}, %q{Gemfile.lock}, %q{History.txt}, %q{README.rdoc}, %q{Rakefile}, %q{lib/safariwatir.rb}, %q{lib/safariwatir/core_ext.rb}, %q{lib/safariwatir/element_attributes.rb}, %q{lib/safariwatir/locators.rb}, %q{lib/safariwatir/scripter.rb}, %q{lib/watir/exceptions.rb}, %q{safariwatir.gemspec}, %q{safariwatir_example.rb}, %q{test.rb}, %q{Manifest}]
  s.homepage = %q{http://wiki.openqa.org/display/WTR/SafariWatir}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Safariwatir}, %q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{safariwatir}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Automated testing tool for web applications.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rb-appscript>, [">= 0"])
      s.add_development_dependency(%q<rb-appscript>, [">= 0"])
    else
      s.add_dependency(%q<rb-appscript>, [">= 0"])
      s.add_dependency(%q<rb-appscript>, [">= 0"])
    end
  else
    s.add_dependency(%q<rb-appscript>, [">= 0"])
    s.add_dependency(%q<rb-appscript>, [">= 0"])
  end
end
