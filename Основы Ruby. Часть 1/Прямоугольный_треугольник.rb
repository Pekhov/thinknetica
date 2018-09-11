print "Введите 3 стороны треугольника через запятую "
all_side = Array(gets.chomp.split(','))
temp_array = all_side.clone
hypotenuse = all_side.collect!(&:to_i).max # Нашли гипотенузу
all_side.each_with_index do |side, index|
  if side == hypotenuse
    all_side.delete_at(index) # Удаляем первую попавшуюся сторону, которая является гипотенузой и выходим из цикла. В массиве останутся две другие стороны.
    break
  end
end
if hypotenuse**2 == all_side.first**2 + all_side.last**2
  puts "Треугольник прямоугольный"
end
if temp_array.uniq! # Возвращает nil, если повторяющиеся элементы в массиве array отсутствовали. А если не nil, то как минимум 2 стороны равны.
  puts "Треугольник равнобедренный"
end