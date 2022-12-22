# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'language_detection/version'

Gem::Specification.new do |gem|
  gem.name          = "language_detection"
  gem.version       = LanguageDetection::VERSION
  gem.authors       = ["Vojtech Hyza"]
  gem.license       = 'MIT'
  gem.email         = ["vhyza@vhyza.eu"]
  gem.description   = %q{Ruby bindings for Chromium Compact Language Detector}
  gem.summary       = <<-EOF
    Ruby bindings for Chromium Compact Language Detector ([source](http://src.chromium.org/viewvc/chrome/trunk/src/third_party/cld/)).
    This gem is using source codes from [chromium-compact-language-detector](http://code.google.com/p/chromium-compact-language-detector/) port.
  EOF
  gem.homepage      = "https://github.com/vhyza/language_detection"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.extensions    = ["ext/cld/extconf.rb"]

  gem.add_runtime_dependency "ffi", "~> 1.12"

  gem.add_development_dependency "rake", "~> 13"
  gem.add_development_dependency "shoulda", "~> 4"
  gem.add_development_dependency "mocha", "~> 2"
  gem.add_development_dependency "test-unit", "~> 3"

  gem.required_ruby_version = [ ">= 2.5.0", "< 3.3.0" ]
end
