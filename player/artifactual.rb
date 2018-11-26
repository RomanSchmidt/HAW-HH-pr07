require './player/a_player'

# Author: Roman Schmidt, Daniel Osterholz
#
# ai logic here
class Artifactual
  include APlayer

  def initialize(input, renderer, match)
    super(input, renderer, match)
    @size = Match::SYMBOLS.length
  end

  def get_code
    Match::SYMBOL_NUMBER.times do
      @symbols_to_guess.push(Match::SYMBOLS[rand(@size)])
    end
    @symbols_to_guess
  end

  protected

  # todo make it better
  def get_single_guess(no)
    Match::SYMBOLS[rand(@size)]
  end
end