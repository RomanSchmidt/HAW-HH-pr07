require './game/match'

# Author: Roman Schmidt, Daniel Osterholz
#
# Own central class to hold the logic for this game.
class Logic

  attr_reader(:blacks, :whites)

  def initialize(match)
    @match = match
    @whites = 0
    @blacks = 0
    @tips = []
  end

  # get whites and blacks from guess depending on @match
  # no whites for black positions
  # no whites several times for a symbol which is guessed more then one times
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
    @match.class::SYMBOL_NUMBER == @blacks
  end

  # each tip just one time as long we didn't reach the limit of guesses. else reset guesses
  def get_tip
    @tips = [] if @tips.size == @match.class::SYMBOLS.size
    begin
      random_symbol = @match.class::SYMBOLS.sample
    end while @tips.include? random_symbol
    @tips.push(random_symbol)

    found_counter = 0
    @match.code.each do |code|
      found_counter += 1 if code == random_symbol
    end
    {symbol: random_symbol, times: found_counter}
  end

  private

  # give just one time a white for a symbol on a wrong position. even it is more then one time there
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

  # check if its a black one and remove from the collection
  def is_black?(codes, element, own_pos)
    if element == codes[own_pos]
      codes[own_pos] = nil
      @blacks += 1
      return true
    end
    false
  end
end