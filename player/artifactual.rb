require './player/a_player'

class Artifactual
  include APlayer

  def initialize(type, input, renderer, match)
    super(type, input, renderer, match)
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