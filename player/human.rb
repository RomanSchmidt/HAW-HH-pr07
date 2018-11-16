require './player/a_player'
require './interface/input'
require './interface/renderer'

class Human
  include APlayer

  def get_code
    i = 0
    begin
      @renderer.draw_enter_code(Match::SYMBOLS, i +=1)
      @symbols_to_guess.push(@input.get_symbol(Match::SYMBOLS))
    end while @symbols_to_guess.size < Match::SYMBOL_NUMBER
    @symbols_to_guess
  end

  def get_guess
    @renderer.draw_single_guess(@match.guess_no + 1, Match::SYMBOLS)
    super
  end

  protected

  def get_single_guess(no)
    @renderer.draw_get_guess(no)
    @input.get_symbol(Match::SYMBOLS)
  end
end