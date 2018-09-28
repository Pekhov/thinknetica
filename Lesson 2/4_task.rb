alphabet = ('a'..'z').to_a
vowels = ['a', 'e', 'i', 'o', 'u', 'y']
hash = {}
vowels.each_with_index(1) do |char, index|
  hash[char] = alphabet.index(char) + 1
end
puts hash