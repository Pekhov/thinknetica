alphabet = ('a'..'z').to_a
vowels = ['a', 'e', 'i', 'o', 'u', 'y']
hash = Hash.new
vowels.each do |char|
  hash[char] = alphabet.index(char) + 1
end