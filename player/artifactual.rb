require './player/a_player'

class Artifactual
  include APlayer

  def get_code
    @size = Match::SYMBOLS.size - 1
    Match::SYMBOL_NUMBER.times do
      @symbols_to_guess.push(Match::SYMBOLS[rand(@size)])
    end
  end

  protected

  # todo make it better
  def get_single_guess(no)
    Match::SYMBOLS[rand(@size)]
  end
end