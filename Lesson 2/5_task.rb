print "Введите дату в формате ДД.ММ.ГГГГ "
day, month, year = gets.chomp.split('.').map!(&:to_i)
intercalary_year = year % 4 == 0 && year % 100 != 0 || year % 400 == 0
months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months[1] = 29 if intercalary_year
current_day = month == 1 ? day : months.take(month - 1).inject(:+) + day
puts "Текущий день с начала года является: #{current_day}"
