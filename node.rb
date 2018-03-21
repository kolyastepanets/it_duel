class Node
  attr_accessor :matrix, :shot_step, :parent, :children, :figure, :figures

  def initialize(options={})
    @matrix = options[:matrix].dup
    @shot_step = options[:shot_step] || []
    @children = options[:children] || []
    @parent = options[:parent]
    @figure = options[:figure] || []
    @figures = options[:figures] || []
  end
end
