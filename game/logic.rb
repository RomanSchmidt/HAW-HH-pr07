require './game/match'

class Logic

  attr_reader(:blacks, :whites)

  def initialize
    @match = nil
    @whites = 0
    @blacks = 0
  end

  def start_new_match(match)
    @match = match
    @whites = 0
    @blacks = 0
  end

  def analyze_guess(guess)
    @whites = 0
    @blacks = 0
    codes = @match.code.clone
    colors_to_ignore = []
    guess.each_with_index do |guess_element, key|
      unless is_black?(codes, guess_element, key)
        if is_white?(codes, guess_element, key, colors_to_ignore)
          colors_to_ignore.push(guess_element)
        end
      end
    end
    self
  end

  def guess_correct?
    @match.class::SYMBOL_NUMBER == @blacks || @match.class::MAX_ROUND == @match.guess_results
  end

  private

  def is_white?(codes, element, ignore_pos, symbols_to_ignore)
    return false if symbols_to_ignore.include?(element)
    codes.each_with_index do |code_element, key|
      next if key == ignore_pos
      if element == code_element
        codes[key] = nil
        @whites += 1
        return true
      end
    end
    false
  end

  def is_black?(codes, element, own_pos)
    if element == codes[own_pos]
      codes[own_pos] = nil
      @blacks += 1
      return true
    end
    false
  end
end