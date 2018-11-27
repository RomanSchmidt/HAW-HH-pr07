require 'test/unit'
require './player/artifactual'
require './player/a_player'
require './interface/renderer'
require './interface/input'
require './game/match'

class ArtifactualTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @renderer = Renderer.new
    @input = Input.new(@renderer)
    @breaker = Artifactual.new(APlayer::CODE_BREAKER, @input, @renderer)
    @maker = Artifactual.new(APlayer::CODE_MAKER, @input, @renderer)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_get_code
    code = @maker.get_code
    assert_true(code.is_a? Array)
    assert_equal(Match::SYMBOL_NUMBER, code.size)
    code.each do |symbol|
      assert_true(Match::SYMBOLS.include?(symbol))
    end
  end

  def test_get_guess
    code = @breaker.get_guess
    assert_true(code.is_a? Array)
    assert_equal(Match::SYMBOL_NUMBER, code.size)
    code.each do |symbol|
      assert_true(Match::SYMBOLS.include?(symbol))
    end
  end
end