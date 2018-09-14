array = [0, 1]
while true
  fibonacci = array[-1] + array[-2]
  fibonacci < 100 ? array << array[-1] + array[-2] : break
end