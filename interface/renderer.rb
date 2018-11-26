# Author: Roman Schmidt, Daniel Osterholz
#
# Class to handle all outputs
class Renderer
  private

  # Change the output tables shorter or larger in default length.
  OUTPUT_LENGTH = 100

  public

  def draw_error_entry(valid_range)
    draw_error('Entered value not valid! Please enter between ' + valid_range.first.to_s + ' and ' + valid_range.last.to_s + '!')
  end

  def draw_offer_tip
    cls
    draw_input('Want tip? (0 = no | 1 = yes)')
  end

  def draw_tip(tip)
    draw_box("The Symbol #{tip[:symbol]}, exists #{tip[:times]} time(s).")
    cls
  end

  def draw_single_guess(no, symbols)
    draw_box('Guess #' + no.to_s + ' ' + symbols_to_s(symbols))
  end

  def draw_get_guess(no)
    draw_input("Symbol ##{no}")
  end

  def draw_play_again
    draw_input('Play again? (0 = no | 1 = yes)')
  end

  def draw_welcome
    draw_line('Welcome to Mastermind!')
  end

  def draw_bye
    cls
    draw_line('CU!')
  end

  def draw_choose_code_maker
    draw_input('Choose Code Maker. (1 for Human | 2 for AI)')
  end

  def draw_choose_code_breaker
    draw_input('Choose Code Breaker. (1 for Human | 2 for AI)')
  end

  def draw_enter_code(symbols, no)
    draw_input("Enter Code ##{no} (#{symbols_to_s(symbols)})")
  end

  def draw_match_table(match, guess_no, match_finished, code)
    cls
    draw_table_header('Try ' + guess_no.to_s + ' / ' + match.class::MAX_ROUND.to_s)
    match.guess_results.each_with_index do |guess_result, key|
      draw_table_element(
          [
              '#',
              (key + 1).to_s,
              ' [',
              guess_result[:guess].join(' '),
              '] (whites: ',
              guess_result[:whites].to_s,
              '; blacks: ',
              guess_result[:blacks].to_s,
              ')'
          ].join('')
      )
    end
    draw_table_footer(match_finished ? "Won #{match.players[APlayer::CODE_BREAKER].won_times} time(s)! (#{code.join(' ')})" : nil)
  end

  def cls
    printf("\n%1$s\n\n", '˭' * (Renderer::OUTPUT_LENGTH + 2))
  end

  private

  def symbols_to_s(symbols)
    symbols_string_array = []
    symbols.each_with_index do |symbol, key|
      symbols_string_array.push(', ') if symbols_string_array.size > 0
      symbols_string_array
          .push('[')
          .push(symbol.to_s)
          .push(' : ')
          .push((key + 1).to_s)
          .push(']')
    end
    symbols_string_array.join('')
  end

  # Output with colorizing content red in needed default length.
  def draw_error(value)
    draw_table_header
    printf("%1$s \e[31m%2$-#{Renderer::OUTPUT_LENGTH - 6}s\e[0m %1$5s\n", '║', 'ERROR: ' + value.to_s)
    draw_table_footer
  end

  def draw_box(value)
    draw_table_header
    delta = get_colored_value_length_delta(value)
    printf("%1$s %2$-#{Renderer::OUTPUT_LENGTH - 6 + delta}s %1$5s\n", '║', value.to_s)
    draw_table_footer
  end

  def draw_table_header(header = '')
    cleaned_header = header.strip
    cleaned_header = ' ' + cleaned_header + ' ' if cleaned_header.size > 0
    line_length = calculate_line_length(cleaned_header)
    printf("╔%1$s%2$s%3$s╗\n", '═' * line_length.ceil, cleaned_header, '═' * line_length.floor)
  end

  def draw_table_footer(footer = '')
    cleaned_footer = (footer.is_a? String) ? footer.strip : ''
    cleaned_footer = ' ' + cleaned_footer + ' ' if cleaned_footer.size > 0
    line_length = calculate_line_length(cleaned_footer) + (get_colored_value_length_delta(cleaned_footer) / 2)
    printf("╚%1$s%2$s%3$s╝\n", '═' * line_length.ceil, cleaned_footer, '═' * line_length.floor)
  end

  def calculate_line_length(value)
    value_size = value.length.to_f
    line_length = (Renderer::OUTPUT_LENGTH.to_f - value_size) / 2.0
    [line_length, (Renderer::OUTPUT_LENGTH.to_f - value_size) / 2.0].min
  end

  def draw_table_element(element)
    delta = get_colored_value_length_delta(element)
    printf("%1$s %2$-#{Renderer::OUTPUT_LENGTH - 6 + delta}s %1$5s\n", '║', element.to_s)
  end

  def get_colored_value_length_delta(value)
    length_with_color = value.to_s.length
    length_without_color = value.to_s.gsub(/\e\[(\d+)(;\d+)*m/, '').length
    length_with_color - length_without_color
  end

  def draw_line(value)
    draw(value + "\n")
  end

  def draw_input(value)
    draw(value + ':')
  end

  def draw(value)
    printf(" %1$-#{Renderer::OUTPUT_LENGTH - 6}s", value.to_s)
  end
end