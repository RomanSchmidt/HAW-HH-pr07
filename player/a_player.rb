require './interface/input'
require './interface/renderer'

# Author: Roman Schmidt, Daniel Osterholz
#
# Abstract to share logic between every player types
module APlayer
  CODE_MAKER = :codeMaker
  CODE_BREAKER = :codeBreaker

  attr_reader(:won_times)

  def initialize(type, input, renderer)
    raise(ArgumentError, 'type is not valid') unless (type == APlayer::CODE_MAKER || type == APlayer::CODE_BREAKER)
    raise(ArgumentError, 'input is not valid') unless input.is_a? Input
    raise(ArgumentError, 'renderer is not valid') unless renderer.is_a? Renderer

    @type = type
    @symbols_to_guess = []
    @input = input
    @renderer = renderer
    @won_times = 0
  end

  def increase_won_times
    @won_times += 1
  end

  def get_code
  end

  def get_guess
  end

  def analyse_last_guess(last_guess, whites, blacks)
  end

  def new_round
  end
end