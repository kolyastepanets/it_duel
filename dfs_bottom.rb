require './node'
require './matrix'
require 'pry'

class DfsBottom
  def has_one_element?(matrix)
    !matrix.to_a.flatten.compact.group_by{ |i| i }.detect{ |k, v| v.length == 1 }.nil?
  end

  def proccess(matrix, show_step = false)
    current_node = Node.new({ matrix: matrix.clone, shot_step: [] })

    loop do
      shot_step = find_step(current_node)

      if shot_step
        matrix_before_iteration(current_node.matrix, shot_step) if show_step
        figure = build_figure(shot_step, current_node.matrix)
        cloned_matrix = current_node.matrix.clone
        matrix = make_nil(figure, cloned_matrix)
        matrix = resize(matrix)
        node = Node.new({ matrix: matrix, shot_step: shot_step, parent: current_node, figure: figure })
        current_node.children << node
        current_node = node
        matrix_after_iteration(matrix) if show_step

        return solution(current_node) if solved?(current_node.matrix)
      else
        if current_node.parent
          current_node = current_node.parent
          next
        else
          return 'unsolvable!'
        end
      end
    end
  end

  def matrix_before_iteration(matrix, shot_step)
    p '>'*100
    p 'Start'
    draw matrix
    p "Step: #{shot_step}"
  end

  def matrix_after_iteration(matrix)
    draw matrix
    p 'End'
    p '<'*100
  end

  def solved?(matrix)
    matrix[matrix.row_count - 1, 0].nil?
  end

  def find_step(node)
    return if has_one_element?(node.matrix)

    matrix = node.matrix
    matrix.each_with_index do |e, row, col|
      row = matrix.column_count - 1 - row
      e = matrix[row, col]
      next if e.nil?
      next if figure_used?([row, col], node)
      return [row, col] if ((col + 1 < matrix.column_count) && e == matrix[row, col + 1] ||
                           (col - 1 >= 0) && e == matrix[row, col - 1] ||
                           (row + 1 < matrix.row_count) && e == matrix[row + 1, col] ||
                           (row - 1 >= 0) && e == matrix[row - 1, col])
    end
    nil
  end

  def figure_used?(shot_step, node)
    figure = build_figure(shot_step, node.matrix)
    figures_equal = false
    node.children.each do |child|
      figures_equal = child.figure.sort == figure.sort
      break if figures_equal
    end
    figures_equal
  end

  def build_figure(shot_step, matrix)
    return unless shot_step

    element = matrix[shot_step[0], shot_step[1]]
    figure = [shot_step]

    figure.each do |item|
      row = item[0]
      col = item[1]

      if (row + 1 < matrix.row_count) && element == matrix[row + 1, col]
        figure << [row + 1, col] unless figure.include?([row + 1, col])
      end

      if (row - 1 >= 0) && element == matrix[row - 1, col]
        figure << [row - 1, col] unless figure.include?([row - 1, col])
      end

      if (col + 1 < matrix.column_count) && element == matrix[row, col + 1]
        figure << [row, col + 1] unless figure.include?([row, col + 1])
      end

      if (col - 1 >= 0) && element == matrix[row, col - 1]
        figure << [row, col - 1] unless figure.include?([row, col - 1])
      end
    end
    figure
  end

  def make_nil figure, matrix
    new_matrix = matrix
    figure.each do |row, col|
      new_matrix[row, col] = nil
    end
    new_matrix
  end

  def resize matrix
    new_1 = []
    new_array = matrix.to_a

    new_matrix = (Matrix.columns new_array).to_a

    size = matrix.row_count

    new_matrix.each do |arr|
      arr.compact!

      next if arr.empty?

      size.times do
        arr.unshift(nil) unless arr.length == size
      end

      new_1 << arr
    end

    array_of_nil = Array.new(size)

    size.times do
      new_1.push(array_of_nil) unless new_1.length == size
    end

    Matrix.columns new_1
  end

  def draw(matrix)
    puts '='*80
    puts matrix.to_readable
    puts '='*80
  end

  def solution node
    solution = []
    loop do
      break unless node.parent
      solution << node.shot_step
      node = node.parent
    end
    solution.reverse
  end

  def tests solution, matrix
    solution.each do |shot_step|
      figure = build_figure shot_step, matrix
      matrix = make_nil figure, matrix
      matrix = resize matrix
      puts "Step: #{shot_step}"
      draw matrix
    end
  end
end
