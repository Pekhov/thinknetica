print "Введите 3 стороны треугольника через запятую "
all_side = gets.chomp.split(',').map(&:to_i)
all_side.sort!
right_triangle = all_side[2]**2 == all_side[0]**2 + all_side[1]**2
if right_triangle && all_side[0] == all_side[1]
  puts "Треугольник прямоугольный и равнобедренный"
elsif right_triangle
  puts "Треугольник прямоугольный"
end
