require 'test/unit'
require './game/logic'
require './game/match'
require './interface/renderer'

class LogicTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @renderer = Renderer.new
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_match
    match = Match.new(@renderer, Input.new(@renderer))
    logic = Logic.new(match)

    tip = logic.get_tip
    assert_equal(0, tip[:times])
    assert_true(Match::SYMBOLS.include?(tip[:symbol]))
  end

  def test_analyse
    match = Match.new(@renderer, Input.new(@renderer))
    logic = Logic.new(match)

    logic.analyze_guess([Match::SYMBOLS[0]])
    assert_equal(logic.blacks, 0)
    assert_equal(logic.whites, 0)
    assert_false(logic.guess_correct?)
  end
end