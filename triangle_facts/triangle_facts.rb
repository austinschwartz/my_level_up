# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3
  @equ
  @iso
  @sca

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
    equilateral()
    isoceles
    scalene
  end

  def equilateral
    @equ = side1 == side2 && side2 == side3
  end

  def isosceles
    @iso = [side1, side2, side3].uniq.length == 2
  end

  def scalene
    @sca = !(equ || iso)
  end

  def recite_facts
    puts 'This triangle is equilateral!' if equ
    puts 'This triangle is isosceles!',
      'Also, that word is hard to type.' if iso
    puts 'This triangle is scalene and mathematically boring.' if sca
    angles = calculate_angles(side1, side2, side3)
    puts 'The angles of this triangle are ' + angles.join(',')
    puts 'This triangle is also a right triangle!' if angles.include? 90
    puts ''
  end

  def calculate_angles(a, b, c)
    a2 = a**2
    b2 = b**2
    c2 = c**2
    radians_a = Math.acos((b2 + c2 - a2) / (2.0 * b * c))
    radians_b = Math.acos((a2 + c2 - b2) / (2.0 * a * c))
    radians_c = Math.acos((a2 + b2 - c2) / (2.0 * a * b))
    angle_a = radians_to_degrees(radians_a)
    angle_b = radians_to_degrees(radians_b)
    angle_c = radians_to_degrees(radians_c)

    [angle_a, angle_b, angle_c]
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end


triangles = [
  [5, 5, 5],
  [5, 12, 13],
]
triangles.each do |sides|
  tri = Triangle.new(*sides)
  tri.recite_facts
end
