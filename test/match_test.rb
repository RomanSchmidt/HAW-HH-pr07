require 'test/unit'
require './game/match'
require './interface/renderer'

class MyTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @renderer = Renderer.new
    @match = Match.new(@renderer, Input.new(@renderer))
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_guess_no
    assert_equal(0, @match.guess_no)
  end
end