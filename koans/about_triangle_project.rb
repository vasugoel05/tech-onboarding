require File.expand_path(File.dirname(__FILE__) + '/neo')

# You need to write the triangle method in the file 'triangle.rb'
require './triangle'

class AboutTriangleProject < Neo::Koan
  def test_equilateral_triangles_have_equal_sides
    assert_equal "Valid Triangle", triangle(2, 2, 2)
    assert_equal "Valid Triangle", triangle(10, 10, 10)
  end

  def test_isosceles_triangles_have_exactly_two_sides_equal
    assert_equal "Valid Triangle", triangle(3, 4, 4)
    assert_equal "Valid Triangle", triangle(4, 3, 4)
    assert_equal "Valid Triangle", triangle(4, 4, 3)
    assert_equal "Valid Triangle", triangle(10, 10, 2)
  end

  def test_scalene_triangles_have_no_equal_sides
    assert_equal "Valid Triangle", triangle(3, 4, 5)
    assert_equal "Valid Triangle", triangle(10, 11, 12)
    assert_equal "Valid Triangle", triangle(5, 4, 2)
  end
end


def triangle(a, b, c)
  # Ensure all sides are positive
  raise TriangleError, "Sides must be positive" if a <= 0 || b <= 0 || c <= 0
  
  # Ensure the sides form a valid triangle (Triangle Inequality Theorem)
  raise TriangleError, "Invalid triangle" if a + b <= c || a + c <= b || b + c <= a
  
  # Determine the type of triangle
  if a == b && b == c
    :equilateral
  elsif a == b || b == c || a == c
    "Valid Triangle"
  else
    "Valid Triangle"
  end
end

class TriangleError < StandardError; end



