# frozen_string_literal: true

require_relative 'codebreaker'
require_relative 'ui'
# UI for testing CogeBreaker module
module UI
  game = Codebreaker::Game.new
  result = ''
  @name = false
  UI.help

  loop do
    @name = UI.name unless @name
    puts 'New game was started...' if game.start

    loop do
      user_option = UI.capture_guess
      p game.hint if %w[h help hint].include? user_option
      next if user_option !~ /^[1-6]{4}$/
      p result = game.compare_with(user_option)
      break if game.attempts <= 0 || result == '++++'
    end

    result == '++++' ? UI.won(@name, game.attempts) : UI.lost # ATTEMPTS - attempts
    # game.save_score(@name) if UI.save?
    break unless UI.repeat_game?
  end
  puts 'CodeBreaker'.center(33, '=')
end