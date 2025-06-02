class Vector2
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def *(other)
    case other
    when Numeric
      Vector2.new(@x * other, @y * other)
    when Vector2
      # Dot product
      @x * other.x + @y * other.y
    else
      raise TypeError, "Cannot multiply Vector2 with #{other.class}"
    end
  end

  def coerce(other)
    [self, other]
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end

# Add multiplication support for Numeric * Vector2
class Numeric
  def *(vector)
    if vector.is_a?(Vector2)
      vector * self
    else
      super
    end
  end
end

# Test cases
v = Vector2.new(3, 4)
puts v * 2      # Output: (6, 8)
puts v * 2.5    # Output: (7.5, 10.0)
puts v * v      # Output: 25 (dot product)
puts 2 * v      # Output: (6, 8)
puts 2.5 * v    # Output: (7.5, 10.0)
