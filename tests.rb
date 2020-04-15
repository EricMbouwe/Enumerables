require_relative 'enumerable'

puts 'Tests on our Enumerable methods: '
puts "\n\nGiven array arr = [1,5,74,1,87,6,97,9]"
arr = [1, 5, 74, 1, 87, 6, 97, 9]
puts "\n"

puts "my_each tests\n\n"
puts "Print each item of the array: \n\n"
print 'arr.my_each #=> '
arr.my_each { |item| print "#{item} " }
puts "\n\n\n"

puts "my_each_with_index tests\n\n"
puts 'Print each index of the array: '
puts "arr.my_each_with_index #=> \n\n"
arr.my_each_with_index { |item, i| puts "index #{i}: #{item}\n\n" }
puts "\n\n"

puts "my_select tests\n\n"
puts 'Print from the array all the selected items(ie: even) defined in the bloc'
even = proc { |item| item.even? }
selected = arr.my_select(&even)
puts "arr.my_select{ |item| item.even?} #=> #{selected.inspect} "
puts "\n\n"

puts "my_all tests\n\n"
puts "Given array tab = %w[ant beart cat]\n\n"
tab = %w[ant bear cat]
puts "Print from the array if the items's condition defined in the bloc or not is true or false\n\n"
my_all = tab.my_all? { |word| word.length >= 3 }
my_all1 = tab.my_all? { |word| word.length >= 4 }
puts "tab.my_all?{ |word| word.length >= 3 } #=> #{my_all}\n\n"
puts "tab.my_all?{ |word| word.length >= 4 } #=> #{my_all1}\n\n"
all_rgx = tab.my_all?(/t/)
puts "tab.my_all?(/t/) #=> #{all_rgx}\n\n"
all_num = [1, 2i, 3.14].my_all?(Numeric)
puts "[1, 2i, 3.14].my_all?(Numeric)  #=> #{all_num}\n\n"
all_bool = [nil, true, 99].my_all?
puts "[nil, true, 99].my_all? #=> #{all_bool}\n\n"
all_empty = [].my_all?
puts "[].my_all? #=> #{all_empty}\n\n\n"

puts "my_any tests\n\n"
puts "Given array tab = %w[ant beart cat]\n\n"
tab = %w[ant bears cats]
puts "Print from the array if the items's condition defined in the bloc or not is true or false\n\n"
my_any = tab.my_any? { |word| word.length >= 3 }
my_any1 = tab.my_any? { |word| word.length > 5 }
puts "tab.my_any?{ |word| word.length >= 3 } #=> #{my_any}\n\n"
puts "tab.my_any?{ |word| word.length > 5 } #=> #{my_any1}\n\n"
any_rgx = tab.my_any?(/d/)
puts "tab.my_any?(/d/) #=> #{any_rgx}\n\n"
any_num = [1, 2i, 3.14].my_any?(Numeric)
puts "[1, 2i, 3.14].my_any?(Integer)  #=> #{any_num}\n\n"
any_bool = [nil, true, 99].my_any?
puts "[nil, true, 99].my_any? #=> #{any_bool}\n\n"
any_empty = [].my_any?
puts "[].my_any? #=> #{any_empty}\n\n\n"

puts "my_none tests\n\n"
none_l = %w[ant bear cat].my_none? { |word| word.length == 5 }
puts "%w{ant bear cat}.my_none? { |word| word.length == 5 } #=> #{none_l}\n\n"
none_rgx = %w[ant bear cat].my_none?(/d/)
puts "%w{ant bear cat}.my_none?(/d/) #=> #{none_rgx}\n\n"
none_f = [1, 3.14, 42].my_none?(Float)
puts "[1, 3.14, 42].my_none?(Float) #=> #{none_f}\n\n"
none_empty = [].my_none?
puts "[].my_none? #=> #{none_empty}\n\n"
none_bool = [nil, false, true].my_none?
puts "[nil, false, true].my_none? #=> #{none_bool}\n\n\n"

puts 'my_count tests'
puts "\nGiven the array ary = [1, 2, 4, 2]\n\n"
ary = [1, 2, 4, 2]
count = ary.my_count
puts "[1, 2, 4, 2].my_count #=> #{count}\n\n"
count_p = ary.my_count(2)
puts "[1, 2, 4, 2].my_count(2) #=> #{count_p}\n\n"
count_b = ary.my_count { |x| (x % 2).zero? }
puts "[1, 2, 4, 2].my_count{ |x| x%2==0 } #=> #{count_b}\n\n\n"

puts "my_map tests\n"
puts "\nGiven the array (1..4)\n\n"
map = (1..4).my_map
map_b = (1..4).my_map { |i| i * i }
puts "(1..4).my_map #=> #{map}\n\n"
puts "(1..4).my_map { |i| i*i } #=> #{map_b}\n\n"
puts "Given a proc bob = { |x| x+5 }\n\n"
bob = proc { |x| x + 5 }
map_p = (1..4).my_map(&bob)
puts "(1..4).my_map(&bob) #=> #{map_p}\n\n"

puts "\nmy_inject tests\n"
puts "\nGiven the array (5..10)\n\n"
inject = (5..10).my_inject(1, :*)
inject_s = (5..10).my_inject(:+)
inject_b = (5..10).my_inject { |sum, n| sum + n }
bil = proc { |product, n| product * n }
inject_p = (5..10).my_inject(&bil)
puts "(5..10).my_inject(1, :*) #=> #{inject}\n\n"
puts "(5..10).my_inject(:+) #=> #{inject_s}\n\n"
puts "(5..10).my_inject{ |sum, n| sum + n } #=> #{inject_b}\n\n"
puts "Given a proc bil = proc { |product, n| product * n }\n\n"
puts "(5..10).my_inject(&bil) #=> #{inject_p}\n\n\n"
puts "Given the array digits = [2,4,5]\n\n"
digits = [2, 4, 5]
multiply = multiply_els(digits)
puts "multiply_els(digits) #=> #{multiply}\n\n"

puts [1, 5, 2].each
puts [1, 5, 2].my_each
puts [1, 5, 2].each_with_index
puts [1, 5, 2].my_each_with_index
puts [1, 5, 2].select
puts [1, 5, 2].my_select
puts [1, 5, 2].all?
puts [1, 5, 2].my_all?
puts [1, 5, 2].any?
puts [1, 5, 2].my_any?
puts [1, 5, 2].none?
puts [1, 5, 2].my_none?
puts [1, 5, 2].count
puts [1, 5, 2].my_count
puts [1, 5, 2].map
puts [1, 5, 2].my_map

my_proc = proc { |num| num > 10 }
print 'bloc and proc given as argument #=> '
puts [18, 22, 5, 6].my_map(my_proc) { |num| num < 10 }.inspect

puts [1, 5, 2].my_inject
puts [nil, false, true, []].all?
puts [nil, false, true, []].my_all?
