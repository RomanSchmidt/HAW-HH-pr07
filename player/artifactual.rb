require './player/a_player'

# Author: Roman Schmidt, Daniel Osterholz
#
# ai logic here
class Artifactual
  include APlayer

  def initialize(type, input, renderer)
    super(type, input, renderer)
    @size = Match::SYMBOLS.length
    @possible_codes = []
  end

  def get_code
    @symbols_to_guess = []
    Match::SYMBOL_NUMBER.times do
      @symbols_to_guess.push(Match::SYMBOLS[rand(@size)])
    end
    @symbols_to_guess
  end

  def get_guess
    generate_possible_codes if @possible_codes.size == 0
    random_guess_no = rand(@possible_codes.size)
    guess = @possible_codes[random_guess_no]
    remove_dup_possi(random_guess_no)
    guess
  end

  def analyse_last_guess(last_guess, whites, blacks)
    if (whites + blacks) == 0
      remove_symbols(last_guess)
    end
  end

  def new_round
    generate_possible_codes
  end

  private

  def generate_possible_codes
    if @type == APlayer::CODE_BREAKER
      @possible_codes = Match::SYMBOLS.repeated_permutation(Match::SYMBOL_NUMBER).to_a
    end
  end

  def remove_dup_possi(random_guess_no)
    new_possibilities = []
    @possible_codes.each_with_index do |value, index|
      new_possibilities.push(value) unless index == random_guess_no
    end
    @possible_codes = new_possibilities
    nil
  end

  def remove_symbols(colors)
    new_possibilities = []
    @possible_codes.each do |value|
      found_color = false
      value.each do |possible_color|
        colors.each do |last_guess_color|
          if possible_color == last_guess_color
            found_color = true
            break
          end
        end
        break if found_color
      end
      new_possibilities.push(value) unless found_color
    end
    @possible_codes = new_possibilities
    nil
  end
end