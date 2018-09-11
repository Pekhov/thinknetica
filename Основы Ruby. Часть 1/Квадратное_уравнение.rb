print "Введите 3 коэффициента через запятую "
a, b, c = gets.chomp.split(',').collect!(&:to_i)
dis = b**2 - 4*a*c
puts "Дискриминант равен #{dis}"
case
  when dis.positive?
    x1 = (-b+Math.sqrt(dis))/2*a
    x2 = (-b-Math.sqrt(dis))/2*a
    puts "Корни уравнения: x1=#{x1}, x2=#{x2}"
  when dis.zero?
    x1 = (-b+Math.sqrt(dis))/2*a
    puts "Корень уравнения: x1=#{x1}"
  when dis.negative?
    puts "Корней нет"
end