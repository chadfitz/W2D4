require "byebug"

def no_dupes?(arr)
    counts = Hash.new(0)
    new_arr = []
    arr.each { |ele| counts[ele] += 1 }
    counts.each { |k,v| new_arr << k if v == 1 }
    new_arr
end

p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])            # => []
puts "-----------"

def no_consecutive_repeats?(arr)
    arr.each_with_index do |ele, i|
        if arr[i] == arr[i+1]
            return false
        end
    end
    true
end

p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
p no_consecutive_repeats?(['x'])                              # => true
puts "------------"

def char_indices(str)
    hash = Hash.new { |h,k| h[k]=Array.new }

    str.each_char.with_index { |char, i| hash[char] << i }
    hash
end

p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}
puts "-----------"

def longest_streak(str)
    counts = Hash.new(0)
    str.each_char { |char| counts[char] += 1 }
    sorted = counts.sort_by { |k,v| v }
    sorted[-1][0] * sorted[-1][-1]
end

p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c
puts "-----------"

def bi_prime?(num)
    primes = [2]
    i = 2
    until i == num
        (2...i).each do |x|
            if i % x == 0
                break
            end
            primes << i
        end
        i += 1
    end

    primes.each do |prime1|
        primes.each do |prime2|
            if prime1 * prime2 == num
                return true
            end
        end
    end
    false
end

p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false
puts "-----------"

def vigenere_cipher(message, keys)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    encrypted = ""

    if keys.length == 1
        message.each_char do |char|
            old_i = alphabet.index(char)
            new_i = old_i + keys[0]
            new_char = alphabet[new_i%26]
            encrypted += new_char
        end
    else
        i = 0
        message.each_char do |char|
            old_i = alphabet.index(char)
            new_i = old_i + keys[i % (keys.length)]
            new_char = alphabet[new_i%26]
            encrypted += new_char
            i += 1
        end
    end
    encrypted
end

p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"
puts "-----------"

def vowel_rotate(str)
    vowels = "aeiou"
    str_vowels = ""
    new_str = ""

    str.each_char do |char|
        if vowels.include?(char)
            str_vowels += char
        end
    end
    
    i = 0
    str.each_char do |char|
        if vowels.include?(char)
            # old_i = i
            # new_i = old_i - 1
            new_char = str_vowels[i-1]
            new_str += new_char
            i += 1
        else
            new_str += char
        end
    end
    new_str
end

p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"
puts "-----------"





class String
    def select(&blk)
        new_str = ""
        if blk
            self.each_char { |char| new_str += char if blk.call(char) }
        end
        new_str
    end

    def map!(&blk)
        self.each_char.with_index { |char, i| self[i] = blk.call(char, i) }
        self
    end
end

p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
p "HELLOworld".select          # => ""
puts "-----------"

word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end
p word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
p word_2        # => "DiJkStRa"
puts "------------"


def multiply(a, b)
    return 0 if b == 0
    
    if b > 0
        a + multiply(a, (b - 1))
    else
        a + multiply(-a, -(b - 1))
    end
end

p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
p multiply(-3, -6)      # => 18
p multiply(3, -6)       # => -18
p multiply(-3, 6)       # => -18
puts "----------"

def lucas_sequence(length)
    return [] if length == 0
    return [2] if length == 1
    return [2,1] if length == 2
   
    seq = lucas_sequence(length-1)
    seq << seq[-1] + seq[-2]
    seq
end

p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]
puts "----------"

def prime_factorization(num)
    (2...num).each do |factor|
        if num % factor == 0
            other_factor = num/factor
            return [*prime_factorization(factor), *prime_factorization(other_factor)]
        end
    end
    [num]
end

p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]
