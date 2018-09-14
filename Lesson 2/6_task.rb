purchases = Hash.new
loop do
  print "Введите название товара "
  product_name = gets.chomp
  break if product_name == 'стоп'
  print "Введите цену за единицу "
  price = gets.chomp
  print "Введите количество товара "
  amount = gets.chomp
  purchases[product_name] = {price => amount}
end
product_sum = 0
puts "Вы купили: " + purchases.to_s
purchases.each_pair do |product, hash|
    item_sum = (hash.keys.join.to_f * hash.values.join.to_f).round(3)
    puts "Вы купили товар #{product} на сумму #{item_sum}"
    product_sum += item_sum
end
puts "Всего вы купили товаров на сумму: #{product_sum}"
