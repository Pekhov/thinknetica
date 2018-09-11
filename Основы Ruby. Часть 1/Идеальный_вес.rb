print "Введите ваше имя и рост через запятую "
name, height = gets.chomp.split(',')
ideal_weight = height.to_i - 110
if ideal_weight > 0
  puts "#{name}, ваш идеальный вес: #{ideal_weight}"
else
  puts "Ваш вес уже оптимальный"
end
