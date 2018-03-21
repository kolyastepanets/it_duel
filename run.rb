require 'benchmark'
require 'benchmark/ips'
require './pseudo_node'
require './a_star'
require './bfs_board'
require './dfs_board'
require './dfs_bottom'
require './bfs_bottom'
require './biggest_step_dfs'
require './biggest_step_bfs'
require './tested_matrix'
require './5_5_matrix'
require './6_6_matrix'
require './7_7_matrix'
require './8_8_matrix'
require 'ostruct'

include Benchmark

dfs_board = DfsBoard.new
bfs_board = BfsBoard.new
big_dfs = BiggestStepDfs.new
big_bfs = BiggestStepBfs.new
dfs_bottom = DfsBottom.new
bfs_bottom = BfsBottom.new
a_star = AStar.new

if ARGV[0] == 'bench'
  if ARGV[1] == 'array'
    puts 'array test'
    10.times do
      Benchmark.bm(7) do |x|
        x.report do
          a = []
          (1..9).to_a.each do |number|
            number.times do
              node = PseudoNode.new
              node.figure = Array.new(number, Array.new(2))
              a << node
            end
          end
          b = a.max { |x, y| y.figure.length <=> x.figure.length }
          a.delete(b)
        end
        x.report do
          a = []
          (1..9).to_a.each do |number|
            number.times do
              node = PseudoNode.new
              node.figure = Array.new(number, Array.new(2))
              a << node
            end
          end
          b = a.max_by { |x| x.figure.length }
          a.delete(b)
        end
        x.report do
          a = []
          (1..9).to_a.each do |number|
            number.times do
              node = PseudoNode.new
              node.figure = Array.new(number, Array.new(2))
              a << node
            end
          end
          a.sort! { |x, y| y.figure.length <=> x.figure.length }.shift
        end
      end
    end
  end

  if ARGV[1] == 'astar'
    @matrix_5_5.each do |matrix|
      dfs_board.draw matrix
      puts '3 times A*'
      Benchmark.benchmark(CAPTION, 7, FORMAT, ">avg:") do |x|
        tf = x.report { a_star.proccess(matrix) }
        tt = x.report { a_star.proccess(matrix) }
        tu = x.report { a_star.proccess(matrix) }
        [(tf+tt+tu)/3]
      end
    end
  end

  if ARGV[1] == 'dfs'
    @matrix_7_7.each do |matrix|
      dfs_board.draw matrix
      puts '3 times DFS'
      Benchmark.benchmark(CAPTION, 7, FORMAT, ">avg:") do |x|
        tf = x.report { dfs_board.proccess(matrix) }
        tt = x.report { dfs_board.proccess(matrix) }
        tu = x.report { dfs_board.proccess(matrix) }
        [(tf+tt+tu)/3]
      end
    end
  end

  if ARGV[1] == 'dfs_bottom'
    @matrix_7_7.each do |matrix|
      dfs_board.draw matrix
      puts '3 times DFS bottom'
      Benchmark.benchmark(CAPTION, 7, FORMAT, ">avg:") do |x|
        tf = x.report { dfs_bottom.proccess(matrix) }
        tt = x.report { dfs_bottom.proccess(matrix) }
        tu = x.report { dfs_bottom.proccess(matrix) }
        [(tf+tt+tu)/3]
      end
    end
  end

  if ARGV[1] == 'big_dfs'
    @matrix_7_7.each do |matrix|
      dfs_board.draw matrix
      puts '3 times BiggestDfs'
      Benchmark.benchmark(CAPTION, 7, FORMAT, ">avg:") do |x|
        tf = x.report { big_dfs.proccess(matrix) }
        tt = x.report { big_dfs.proccess(matrix) }
        tu = x.report { big_dfs.proccess(matrix) }
        [(tf+tt+tu)/3]
      end
    end
  end

  if ARGV[1] == 'bfs'
    @matrix_7_7.each do |matrix|
      dfs_board.draw matrix
      puts '3 times BFS'
      Benchmark.benchmark(CAPTION, 7, FORMAT, ">avg:") do |x|
        tf = x.report { bfs_board.proccess(matrix) }
        tt = x.report { bfs_board.proccess(matrix) }
        tu = x.report { bfs_board.proccess(matrix) }
        [(tf+tt+tu)/3]
      end
    end
  end

  if ARGV[1] == 'bfs_bottom'
    @matrix_7_7.each do |matrix|
      dfs_board.draw matrix
      puts '3 times ВFS bottom'
      Benchmark.benchmark(CAPTION, 7, FORMAT, ">avg:") do |x|
        tf = x.report { bfs_bottom.proccess(matrix) }
        tt = x.report { bfs_bottom.proccess(matrix) }
        tu = x.report { bfs_bottom.proccess(matrix) }
        [(tf+tt+tu)/3]
      end
    end
  end

  if ARGV[1] == 'big_bfs'
    @matrix_7_7.each do |matrix|
      dfs_board.draw matrix
      puts '3 times BiggestBfs'
      Benchmark.benchmark(CAPTION, 7, FORMAT, ">avg:") do |x|
        tf = x.report { big_bfs.proccess(matrix) }
        tt = x.report { big_bfs.proccess(matrix) }
        tu = x.report { big_bfs.proccess(matrix) }
        [(tf+tt+tu)/3]
      end
      puts '~'*100
    end
  end

elsif ARGV[0] == 'dfs'
  matrix = Matrix.columns([[2, 0, 0, 0, 0, 0, 3, 3, 3, 3], [2, 1, 1, 2, 2, 2, 2, 4, 4, 4], [2, 2, 1, 4, 0, 0, 0, 0, 0, 4], [2, 1, 1, 4, 3, 3, 3, 4, 4, 4], [1, 1, 1, 4, 4, 4, 2, 2, 0, 0], [1, 1, 0, 4, 4, 4, 0, 0, 0, 4], [1, 1, 0, 2, 2, 3, 3, 3, 0, 4], [1, 1, 1, 1, 3, 0, 3, 3, 3, 0], [2, 2, 2, 1, 3, 4, 4, 3, 3, 0], [2, 3, 3, 3, 3, 0, 0, 0, 0, 0]])
  solution = dfs_board.proccess(matrix)
  p solution
elsif ARGV[0] == 'star'
  matrix = Matrix.columns([[2, 0, 0, 0, 0, 0, 3, 3, 3, 3], [2, 1, 1, 2, 2, 2, 2, 4, 4, 4], [2, 2, 1, 4, 0, 0, 0, 0, 0, 4], [2, 1, 1, 4, 3, 3, 3, 4, 4, 4], [1, 1, 1, 4, 4, 4, 2, 2, 0, 0], [1, 1, 0, 4, 4, 4, 0, 0, 0, 4], [1, 1, 0, 2, 2, 3, 3, 3, 0, 4], [1, 1, 1, 1, 3, 0, 3, 3, 3, 0], [2, 2, 2, 1, 3, 4, 4, 3, 3, 0], [2, 3, 3, 3, 3, 0, 0, 0, 0, 0]])
  a_star.draw matrix
  solution = a_star.proccess(matrix, true)
  p solution
elsif ARGV[0] == 'dfs_bottom'
  matrix = Matrix.columns([[4, 4, 1, 2, 0, 2, 3], [0, 0, 0, 1, 0, 1, 3], [0, 2, 2, 3, 4, 3, 1], [4, 0, 4, 3, 1, 1, 3], [3, 4, 0, 2, 2, 2, 3], [2, 2, 3, 3, 4, 1, 0], [1, 0, 4, 4, 2, 3, 3]])
  solution = dfs_bottom.proccess(matrix)
  p solution
elsif ARGV[0] == 'bfs'
  matrix = Matrix.columns([[2, 0, 0, 0, 0, 0, 3, 3, 3, 3], [2, 1, 1, 2, 2, 2, 2, 4, 4, 4], [2, 2, 1, 4, 0, 0, 0, 0, 0, 4], [2, 1, 1, 4, 3, 3, 3, 4, 4, 4], [1, 1, 1, 4, 4, 4, 2, 2, 0, 0], [1, 1, 0, 4, 4, 4, 0, 0, 0, 4], [1, 1, 0, 2, 2, 3, 3, 3, 0, 4], [1, 1, 1, 1, 3, 0, 3, 3, 3, 0], [2, 2, 2, 1, 3, 4, 4, 3, 3, 0], [2, 3, 3, 3, 3, 0, 0, 0, 0, 0]])
  solution = bfs_board.proccess(matrix, true)
  p solution
elsif ARGV[0] == 'big_dfs'
  @solvables.each do |matrix|
    solution = big_dfs.proccess(matrix)
    p solution
  end
elsif ARGV[0] == 'big_bfs'
  matrix = Matrix.columns([[2, 0, 0, 0, 0, 0, 3, 3, 3, 3], [2, 1, 1, 2, 2, 2, 2, 4, 4, 4], [2, 2, 1, 4, 0, 0, 0, 0, 0, 4], [2, 1, 1, 4, 3, 3, 3, 4, 4, 4], [1, 1, 1, 4, 4, 4, 2, 2, 0, 0], [1, 1, 0, 4, 4, 4, 0, 0, 0, 4], [1, 1, 0, 2, 2, 3, 3, 3, 0, 4], [1, 1, 1, 1, 3, 0, 3, 3, 3, 0], [2, 2, 2, 1, 3, 4, 4, 3, 3, 0], [2, 3, 3, 3, 3, 0, 0, 0, 0, 0]])
  solution = big_bfs.proccess(matrix, true)
  p solution
elsif ARGV[0] == 'draw'
  matrix = Matrix.columns([[2, 0, 0, 0, 0, 0, 3, 3, 3, 3], [2, 1, 1, 2, 2, 2, 2, 4, 4, 4], [2, 2, 1, 4, 0, 0, 0, 0, 0, 4], [2, 1, 1, 4, 3, 3, 3, 4, 4, 4], [1, 1, 1, 4, 4, 4, 2, 2, 0, 0], [1, 1, 0, 4, 4, 4, 0, 0, 0, 4], [1, 1, 0, 2, 2, 3, 3, 3, 0, 4], [1, 1, 1, 1, 3, 0, 3, 3, 3, 0], [2, 2, 2, 1, 3, 4, 4, 3, 3, 0], [2, 3, 3, 3, 3, 0, 0, 0, 0, 0]])
  dfs_board.draw(matrix)
elsif ARGV[0] == 'solution'
  matrix = Matrix.columns([[3, 1, 1, 3, 2, 0, 0], [3, 2, 2, 0, 2, 2, 0], [2, 3, 4, 3, 1, 0, 1], [4, 1, 0, 1, 3, 2, 3], [1, 3, 3, 2, 3, 4, 4], [4, 0, 2, 1, 1, 3, 3], [3, 2, 2, 2, 0, 0, 2]])
  puts "TEST SOLUTION"
  p "*" * 80
  a_star.tests [[1, 4], [4, 0], [5, 4], [5, 0], [4, 1], [3, 5], [1, 6], [5, 5], [6, 3], [5, 2], [4, 0], [5, 5], [6, 2], [5, 1], [5, 0]], matrix
end
