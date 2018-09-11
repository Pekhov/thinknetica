print "Введите 3 стороны треугольника через запятую "
all_side = gets.chomp.split(',').map(&:to_i)
temp_array = all_side.clone
hypotenuse = all_side.max # Нашли гипотенузу
all_side.each_with_index do |side, index|
  if side == hypotenuse
    all_side.delete_at(index) # Удаляем первую попавшуюся сторону, которая является гипотенузой и выходим из цикла. В массиве останутся две другие стороны.
    break
  end
end
if hypotenuse**2 == all_side.first**2 + all_side.last**2
  puts "Треугольник прямоугольный"
  puts "Треугольник равнобедренный" if temp_array.uniq.size == 2
end
