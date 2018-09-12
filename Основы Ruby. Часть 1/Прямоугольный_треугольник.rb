print "Введите 3 стороны треугольника через запятую "
all_side = gets.chomp.split(',').map(&:to_i)
all_side.sort!
check_isosceles = all_side[2]**2 == all_side[0]**2 + all_side[1]**2 ? true: false
if check_isosceles && all_side[0] == all_side[1]
  puts "Треугольник прямоугольный и равнобедренный"
elsif check_isosceles
  puts "Треугольник прямоугольный"
end
