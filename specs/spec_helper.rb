require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'

# Require any classes
require_relative '../lib/player'
require_relative '../lib/scoring'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
