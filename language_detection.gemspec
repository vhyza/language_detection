# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'language_detection/version'

Gem::Specification.new do |gem|
  gem.name          = "language_detection"
  gem.version       = LanguageDetection::VERSION
  gem.authors       = ["Vojtech Hyza"]
  gem.email         = ["vhyza@vhyza.eu"]
  gem.description   = %q{Language detection}
  gem.summary       = %q{Wrapped Chrome's compact language detector}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.extensions    = ["ext/cld/extconf.rb"]

  gem.add_dependency "ffi"
  gem.add_dependency "hashr"

  gem.add_development_dependency "shoulda"
  gem.add_development_dependency "mocha"
  gem.add_development_dependency "turn"
end
