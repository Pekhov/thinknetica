print "Введите высоту и основание треугольника через запятую "
height, base = gets.chomp.split(',').map(&:to_i)
area = 0.5 / 2 * height * base
puts "Площадь треугольника: #{area.to_i}"
