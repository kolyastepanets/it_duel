class PseudoNode
  attr_accessor :figure

  def initialize(options={})
    @figure = options[:figure] || []
  end
end
