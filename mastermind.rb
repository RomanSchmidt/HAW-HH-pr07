require './interface/renderer'
require './interface/input'
require './game/logic'
require './game/match'

class Mastermind
  def initialize
    @renderer = Renderer.new
    @input = Input.new(@renderer)
    @logic = Logic.new
    @match = Match.new(@renderer, @input, @logic)

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
    @renderer.draw_bye(@match.guess_results)
    exit(0)
  end
end

Mastermind.new