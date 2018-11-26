require './interface/renderer'
require './interface/input'
require './player/a_player'
require './player/human'
require './player/artifactual'
require './game/logic'

# Author: Roman Schmidt, Daniel Osterholz
#
# This class holds the mail loop for a match.
class Match
  SYMBOLS = %w['a' 'b' 'c' 'd' 'e' 'f']
  SYMBOL_NUMBER = 4
  MAX_ROUND = 10

  attr_reader(:code, :guess_results, :players)

  def initialize(renderer, input)
    @players = {APlayer::CODE_MAKER => nil, APlayer::CODE_BREAKER => nil}
    @renderer = renderer
    @input = input
    @logic = Logic.new(self)
    @code = []
    @guess_results = []
  end

  def guess_no
    @guess_results.size
  end

  def choose_code_maker
    @renderer.draw_choose_code_maker
    @players[APlayer::CODE_MAKER] = get_player
    self
  end

  def choose_code_breaker
    @renderer.draw_choose_code_breaker
    @players[APlayer::CODE_BREAKER] = get_player
    self
  end

  # on a new match reinitialize and redo match start logic
  def start_new
    @guess_results = []
    @code = []

    choose_code_maker if @players[APlayer::CODE_MAKER].nil?
    choose_code_breaker if @players[APlayer::CODE_BREAKER].nil?

    @logic = Logic.new(self)

    match_finished = false

    @code = @players[APlayer::CODE_MAKER].get_code

    begin
      next_round
      match_finished = @logic.guess_correct? || guess_no === Match::MAX_ROUND
      @renderer.draw_match_table(self, guess_no, match_finished, @code)
    end while match_finished == false
  end

  private

  # each round offer tip, get guess, analyse, save current step, figure out if won
  def next_round
    offer_tip
    guess = @players[APlayer::CODE_BREAKER].get_guess
    @logic.analyze_guess(guess)
    @guess_results.push({:guess => guess, :whites => @logic.whites, :blacks => @logic.blacks, :guesses => guess_no})
    @players[APlayer::CODE_BREAKER].increase_won_times if @logic.guess_correct?
    nil
  end

  def get_player
    player_type_chosen = @input.get_player_type
    player_type_chosen == 0 ? Human.new(@input, @renderer, self) : Artifactual.new(@input, @renderer, self)
  end

  # tips just for humans
  def offer_tip
    return unless @players[APlayer::CODE_BREAKER].is_a? Human
    @renderer.draw_offer_tip
    if @input.get_want_tip?
      @renderer.draw_tip(@logic.get_tip)
    end
    nil
  end
end