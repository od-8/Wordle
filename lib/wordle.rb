# frozen_string_literal: false

require 'colorize'

$game_over = 0

# puts 'input word'
# new_word = gets.chomp.downcase
# new_array = [new_word.split('')]
# p new_array

# Board class
class Board
  def initialize(correct_word)
    @board = Array.new(6) { Array.new(5, '-') }
    @correct_combo = correct_word.split('')
    @w = 0
  end

  def move(guess_word)
    @board[@w] = guess_word.split('')
    @w += 1
  end

  def print_board
    puts ''
    puts '+---+---+---+---+---+'
    @board.each_with_index do |row, _i|
      row.each_with_index do |item, index|
        if @correct_combo[index] == item
          print "| #{item.colorize(:green)} "
        elsif @correct_combo.include?(item) && @correct_combo[index] != item
          print "| #{item.colorize(:yellow)} "
        else
          print "| #{item} "
        end
      end
      print '|'
      puts "\n+---+---+---+---+---+"
    end
  end

  def winner?
    return unless @board.include?(@correct_combo)

    puts ''
    puts 'Congratulations player 1 you have won.'
    puts ''
    $game_over = 1
  end

  def full?
    return unless @board.flatten.all? { |i| i != '-' }

    puts ''
    puts 'Congratualtions player 2 you have won.'
    puts ''
    $game_over = 1
  end
end

i = 0
puts 'Player 2 input the winning word:'
correct_word = gets.chomp.downcase
puts ''

board = Board.new(correct_word)

until $game_over == 1

  puts 'Player 1 input your guess:'
  guess_word = gets.chomp.downcase
  puts ''

  board.move(guess_word)
  board.print_board
  board.winner?
  board.full?
  i += 1
end
