require './interface/renderer'
require './interface/input'
require './game/match'

# Author: Roman Schmidt, Daniel Osterholz
#
# Create required classes, loop each Game if required, print exit in the end
class Mastermind
  def initialize
    @renderer = Renderer.new
    @input = Input.new(@renderer)
    @match = Match.new(@renderer, @input)

    start
  end

  private

  def start
    begin
      @match.start_new
      @renderer.draw_play_again
    end while @input.get_play_again?
    stop
  end

  def stop
    @renderer.draw_bye
    exit(0)
  end
end

Mastermind.new