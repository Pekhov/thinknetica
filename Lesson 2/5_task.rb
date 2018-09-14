print "Введите дату в формате ДД.ММ.ГГГГ "
day, month, year = gets.chomp.split('.').map!(&:to_i)
intercalary_year = (year % 4 == 0) || (year % 400 == 0) || (year % 100 != 0)
months = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months[2] = intercalary_year ? 29 : 28
puts "Текущий день с начала года является: " + (months.values_at(1..month - 1).inject(:+) + day).to_s
