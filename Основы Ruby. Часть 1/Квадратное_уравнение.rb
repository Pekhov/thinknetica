print "Введите 3 коэффициента через запятую "
a, b, c = gets.chomp.split(',').map!(&:to_i)
dis = b ** 2 - 4 * a * c
dis_sqrt = Math.sqrt(dis) if dis > 0
puts "Дискриминант равен #{dis}"
if dis.positive?
    x1 = (-b + dis_sqrt) / (2 * a)
    x2 = (-b - dis_sqrt) / (2 * a)
    puts "Корни уравнения: x1 = #{x1}, x2=#{x2}"
elsif dis.zero?
    x1 = -b / (2 * a)
    puts "Корень уравнения: x1 = #{x1}"
else
    puts "Корней нет"
end
