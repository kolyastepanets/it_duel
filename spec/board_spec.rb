require 'matrix'
require './board'

RSpec.describe Board do
  context '#has_one_element?' do
    it 'checks if matrix has one element' do
      matrix = Matrix.columns [[2, 3, 3, 3], [0, 0, 4, 2], [0, 3, 3, 4], [1, 1, 0, 4]]
      board = Board.new(matrix)

      expect(board.has_one_element?(matrix)).to be_falsey
    end

    it 'checks if matrix does not have one element' do
      matrix = Matrix.columns [[2, 3, 3, 3], [0, 0, 4, 4], [0, 3, 3, 4], [1, 1, 0, 4]]
      board = Board.new(matrix)

      expect(board.has_one_element?(matrix)).to be_truthy
    end
  end

  context '#solved?' do
    it 'checks if matrix solved' do
      matrix = Matrix.columns [[nil, nil], [nil, nil]]
      board = Board.new(matrix)

      expect(board.solved?(matrix)).to be_truthy
    end

    it 'checks if matrix is not solved' do
      matrix = Matrix.columns [[2, 3, 3, 3], [0, 0, 4, 4], [0, 3, 3, 4], [1, 1, 0, 4]]
      board = Board.new(matrix)

      expect(board.solved?(matrix)).to be_falsey
    end
  end

  context '#make_nil' do
    it 'returns matrix with nil elements according to figure' do
      matrix = Matrix.columns [[1, 2], [3, 4]]
      ready_matrix = Matrix.columns [[nil, 2], [nil, 4]]
      board = Board.new(matrix)

      expect(board.make_nil([[0, 0], [0, 1]], matrix)).to eq ready_matrix
    end
  end

  context '#find_step' do
    it 'returns nil if matrix has one element' do
      matrix = Matrix.columns [[2, 3, 3, 3], [0, 0, 4, 4], [0, 3, 3, 4], [1, 1, 0, 4]]
      node = Node.new({ matrix: matrix, shot_step: [] })
      board = Board.new(matrix)

      expect(board.find_step(node)).to be_nil
    end

    it 'returns [row, col] if matrix has 2 equal elements beside' do
      matrix = Matrix.columns [[2, 3, 4, 1], [0, 0, 3, 2], [0, 3, 1, 4], [1, 2, 0, 1]]
      node = Node.new({ matrix: matrix, shot_step: [] })
      board = Board.new(matrix)

      expect(board.find_step(node)).to eq [0, 1]
    end

    it 'returns nil if [row, col] are included in node\'s children figure' do
      matrix = Matrix.columns [[2, 3, 4, 1], [0, 1, 3, 2], [0, 3, 1, 4], [1, 2, 0, 1]]
      root_node = Node.new({ matrix: matrix, shot_step: [] })
      child_node_1 = Node.new({ matrix: matrix, shot_step: [0, 1], parent: root_node, figure: [[0, 1], [0, 2]] })
      child_node_2 = Node.new({ matrix: matrix, shot_step: [0, 2], parent: root_node, figure: [[0, 1], [0, 2]] })
      root_node.children << child_node_1
      root_node.children << child_node_2
      board = Board.new(matrix)

      expect(board.find_step(root_node)).to be_nil
    end
  end

  context '#build_figure' do
    it 'returns figure of besides elements' do
      matrix = Matrix.columns [[2, 3, 3, 3], [0, 0, 4, 4], [0, 3, 3, 4], [1, 1, 0, 4]]
      board = Board.new(matrix)

      expect(board.build_figure([0, 1], matrix)).to match_array [[0, 1], [0, 2], [1, 1]]
    end
  end

  context '#resize' do
    it 'resizes matrix' do
      matrix = Matrix.columns [[2, nil, nil, nil], [0, 0, 4, 4], [nil, nil, nil, nil], [1, 1, 0, 4]]
      resized_matrix = Matrix[[nil, 0, 1, nil], [nil, 0, 1, nil], [nil, 4, 0, nil], [2, 4, 4, nil]]
      board = Board.new(matrix)

      expect(board.resize(matrix)).to eq resized_matrix
    end
  end

  context '#proccess' do
    it 'finds the solution' do
      matrix = Matrix.columns [[2, 3, 3, 3], [0, 0, 4, 2], [0, 3, 3, 4], [1, 1, 0, 4]]
      solution = [[0, 3], [1, 0], [1, 2], [0, 1], [2, 2], [3, 0], [3, 0]]
      board = Board.new(matrix)

      expect(board.proccess).to eq solution
    end

    it 'does not find the solution' do
      matrix = Matrix.columns [[2, 3, 3, 3], [0, 0, 4, 4], [0, 3, 3, 4], [1, 1, 0, 4]]
      board = Board.new(matrix)

      expect(board.proccess).to eq 'unsolvable!'
    end
  end

  context '#figure_used?' do
    it 'returns true' do
      matrix = Matrix.columns [[2, 3, 4, 1], [0, 1, 3, 2], [0, 3, 1, 4], [1, 2, 0, 1]]
      root_node = Node.new({ matrix: matrix, shot_step: [] })
      child_node_1 = Node.new({ matrix: matrix, shot_step: [0, 1], parent: root_node, figure: [[0, 1], [0, 2]] })
      child_node_2 = Node.new({ matrix: matrix, shot_step: [0, 2], parent: root_node, figure: [[0, 1], [0, 2]] })
      root_node.children << child_node_1
      root_node.children << child_node_2
      board = Board.new(matrix)

      expect(board.figure_used?([0, 1], root_node)).to be_truthy
      expect(board.figure_used?([0, 2], root_node)).to be_truthy
    end

    it 'returns false' do
      matrix = Matrix.columns [[2, 3, 4, 1], [0, 1, 3, 2], [0, 3, 1, 4], [1, 2, 0, 1]]
      root_node = Node.new({ matrix: matrix, shot_step: [] })
      board = Board.new(matrix)

      expect(board.figure_used?([0, 1], root_node)).to be_falsey
    end
  end
end
