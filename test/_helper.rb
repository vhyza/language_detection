require 'bundler/setup'

require 'test/unit'
require 'shoulda'
require 'mocha/test_unit'
require File.join(File.expand_path('../../lib/language_detection.rb', __FILE__))

class Test::Unit::TestCase

  def fixture_file(name)
    File.read File.expand_path("../fixtures/#{name}", __FILE__)
  end

end
