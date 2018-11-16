require './interface/input'
require './interface/renderer'

module APlayer
  CODE_MAKER = :codeMaker
  CODE_BREAKER = :codeBreaker

  attr_reader(:won_times)

  # todo check
  def initialize(type, input, renderer, match)
    # eg APlayer::CODE_MAKER
    @type = type
    @symbols_to_guess = []
    @input = input
    @renderer = renderer
    @match = match
    @won_times = 0
  end

  def increase_won_times
    @won_times += 1
  end

  def get_code; end

  def get_guess
    guess = []
    i = 0
    begin
      guess.push(get_single_guess(i = i + 1))
    end while guess.size < Match::SYMBOL_NUMBER
    guess
  end

  protected

  def get_single_guess(no)
  end
end