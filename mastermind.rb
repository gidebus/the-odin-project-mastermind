# TODO: Use following link for references and improvement of code
# https://github.com/kasugaijin/mastermind/blob/main/ruby.rb
# https://github.com/rlmoser99/ruby_Mastermind/blob/master/game_logic.rb

require 'pry-byebug'
class MasterMind

  COMBINATIONS = [1, 2, 3, 4, 5, 6]

  def initialize
    @guess = []
    @secret_code = []
    @turn = 1
    @matches = 0
    @partials = 0
  end

  def generate_secret_code
    4.times do
      @secret_code.append(COMBINATIONS.sample)
    end
  end

  def turn
    puts ''
    puts "Turn: #{@turn}"
    puts 'Enter a 4 digit code using numbers from 1 through 6'
    input = gets.chomp
    input_to_integer(input.split(''))
    puts ''
    @turn +=1
    hints
  end

  def input_to_integer(input)
    @guess = []
    input.each do |num|
      @guess.append(num.to_i)
    end
  end

  def hints
    puts "Matches: #{matches}"
    puts "Partials: #{partials}"
  end

  def matches
    @matches = 0
    @guess.each_with_index do |num, index|
      @secret_code.each_with_index do |secret_num, secret_index|
        if num == secret_num && index == secret_index
          @matches += 1
        end
      end
    end
    return @matches
  end

  def partials
    @partials = 0
    @guess.each_with_index do |num, index|
      @secret_code.each_with_index do |secret_num, secret_index|
        # byebug
        if num == secret_num && index != secret_index
          @partials += 1
        end
      end
    end
    return @partials
  end

  def won?
    @guess == @secret_code
  end

  def lost?
    @turn == 13
  end

  def over?
    won? || lost?
  end

  def reset_game
    puts ''
    puts 'Would you like to play again? Input: y for Yes'
    input = gets.chomp
    if input == 'y'
      self.generate_secret_code
      @turn = 1
      play
    else
      puts ''
      puts 'Thanks for playing Master Mind'
    end

  end

  def play
    until over?
      turn
    end
    if won?
      puts ''
      puts 'You won!'
    else
      puts ''
      puts 'Game over: You could not break the code!'
    end
    reset_game
  end

end

game = MasterMind.new
game.generate_secret_code
game.play
