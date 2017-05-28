require 'pry'

class Ecosystem
  attr_reader :board, :list_of_life

  def initialize board
    @board = board
  end

  def tick
    board.each_with_index.map do |row, row_i|
      row.each_with_index.map do |cell, col_i|
        alive?(cell == 1, alive_neigbour_count(col_i, row_i)) ? 1 : 0
      end
    end
  end

private

  def alive? alive, neigbour_count
    case neigbour_count
      when 0...2
        false
      when 2
        alive
      when 3
        true
      when 4..8
        false
      end
  end

  def alive_neigbour_count x,y
    [
      [x-1,y-1],[x,y-1],[x+1,y-1],
      [x-1,y  ],        [x+1,y  ],
      [x-1,y+1],[x,y+1],[x+1,y+1]
    ].select do |x,y|
      (0...width).include?(x) && (0...height).include?(y)
    end.map do |x,y|

      @board[y][x]
    end.reduce(:+) || 0
  end

  def width
    @board.first.size
  end

  def height
    @board.size
  end
end
