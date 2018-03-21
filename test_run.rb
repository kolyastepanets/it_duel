require './board'

# matrix = Matrix.columns [[1, 4, 4, 3, 2, 2, 2, 3], [0, 4, 1, 2, 1, 4, 0, 4], [0, 0, 4, 1, 2, 1, 0, 4], [3, 2, 3, 0, 1, 4, 4, 3], [0, 3, 0, 2, 3, 1, 2, 4], [3, 2, 2, 1, 2, 3, 3, 3], [1, 3, 2, 1, 2, 4, 1, 2], [0, 0, 3, 3, 0, 1, 3, 3]]
# matrix = Matrix.columns [[1, 4, 3, 4, 3, 1, 3], [2, 3, 3, 0, 0, 1, 3], [4, 4, 1, 2, 0, 3, 1], [2, 2, 1, 3, 0, 3, 1], [3, 2, 3, 0, 4, 4, 1], [1, 1, 4, 3, 2, 1, 3], [1, 4, 1, 1, 0, 0, 4]]

# puts "TEST SOLUTION"
# p "*" * 80
# board.tests [[0, 3], [1, 0], [1, 2], [0, 1], [2, 2], [3, 0], [3, 0]], matrix

# test_matrix = Matrix[[nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil, nil, nil], [4, nil, nil, 3, 2, nil, nil, nil], [1, 4, 2, 1, 4, 2, nil, nil]]



# matrix = Matrix.columns [[2, 3, 3, 3], [0, 0, 4, 2], [0, 3, 3, 4], [1, 1, 0, 4]]
matrix = Matrix.columns [[2, 3, 4, 1], [0, 1, 3, 2], [0, 3, 1, 4], [1, 2, 0, 1]]
board = Board.new matrix
puts 'Initial'
board.draw matrix
# p (board.resize(matrix))
# p matrix[3, 0]
# solution = board.proccess
# p solution
