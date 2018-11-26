require 'scanf'

# Author: Roman Schmidt, Daniel Osterholz
#
# Handle all user input
class Input
  def initialize(renderer)
    @renderer = renderer
  end

  def get_play_again?
    valid_range = 0..1
    get_valid_int(valid_range) == 0 ? false : true
  end

  def get_want_tip?
    valid_range = 0..1
    get_valid_int(valid_range) == 0 ? false : true
  end

  def get_player_type
    valid_range = 1..2
    entry = get_valid_int(valid_range)
    entry - 1
  end

  def get_symbol(symbols)
    valid_range = 1..symbols.size
    entry = get_valid_int(valid_range)
    symbols[entry - 1]
  end

  private

  def get_valid_int(valid_range)
    entry = nil
    entry_valid = false
    begin
      entry = get_int
      entry_valid = valid_range.include?(entry)
      @renderer.draw_error_entry(valid_range) unless entry_valid
    end while entry_valid == false
    entry
  end

  def get_int
    entry = nil
    begin
      entry = gets.chop.to_i
    rescue Exception => e
      # for the case the cli had a ctrl + c on input e.g.
      exit(1)
    end
    entry
  end
end