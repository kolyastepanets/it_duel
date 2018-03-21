require 'matrix'

class Matrix
  public :"[]=", :set_element, :set_component

  def to_readable
    i = 0
    self.each do |number|
      if number.nil?
        print '_' + " "
      else
        print number.to_s + " "
      end
      i+= 1
      if i == self.row_size
        print "\n"
        i = 0
      end
    end
    nil
  end
end
