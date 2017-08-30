require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'

# Require any classes
require_relative '../lib/player'
require_relative '../lib/scoring'
require_relative '../lib/tile_bag'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
