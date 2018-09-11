print "Введите высоту и основание треугольника через запятую "
height, base = gets.chomp.split(',')
area = 1.0/2*height.to_i*base.to_i
puts "Площадь треугольника: #{area.to_i}"