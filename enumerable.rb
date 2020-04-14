module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(to_a[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    result = []
    my_each do |item|
      result << item if yield(item)
    end
    result
  end

  def my_all?(param = nil)
    result = true
    my_each do |value|
      if !block_given?
        result = false unless param === value
      elsif param.nil?
        result = true unless value
      else
        result = false unless yield(value)
      end
    end
    result
  end

  def my_any?(param = nil)
    result = false
    my_each do |value|
      if !block_given?
        result = true if param === value
      elsif param.nil?
        result = true if value
      else
        result = true if yield(value)
      end
    end
    result
  end

  def my_none?(param = nil)
    result = true
    my_each do |value|
      if block_given?
        result = false if yield(value)
      elsif param.nil?
        result = false if value
      else
        result = false if param === value
      end
    end
    result
  end

  def my_count(param = nil)
    count = 0
    my_each do |item|
      if param
        count += 1 if item == param
      elsif block_given?
        count += 1 if yield(item)
      else
        count = length
      end
    end
    count
  end

  def my_map(param = nil)
    return to_enum unless block_given?

    arr = []
    my_each do |item|
      if param
        arr << param.call(item)
      else
        arr << yield(item)
      end
    end
    arr
  end

  def my_inject(param1 = nil, param2 = nil)
    if block_given?
      my_each do |item|
        param1 = param1.nil? ? to_a[0] : yield(param1, item)
      end
      param1
    elsif param1
      i = param2.nil? ? 1 : 0
      accumulator = param2.nil? ? to_a[0] : param1
      operator = param2.nil? ? param1 : param2

      while i < size
        accumulator = to_a[i].send(operator, accumulator)
        i += 1
      end
      accumulator
    else
      to_enum
    end
  end
end

# implementation of my_inject
def multiply_els(arr)
  arr.my_inject('*')
end

puts 'Tests on our Enumerable methods: '
puts "\n\nGiven array arr = [1,5,74,1,87,6,97,9]"
arr = [1, 5, 74, 1, 87, 6, 97, 9]
puts "\n"

puts "my_each tests\n\n"
puts 'Print each item of the array: '
print 'arr.my_each #=> '
arr.my_each { |item| print "#{item} " }
puts "\n\n\n"

puts "my_each_with_index tests\n\n"
puts 'Print each index of the array: '
print 'arr.my_each_with_index #=> '
arr.my_each_with_index { |item, i| print "#{i} => #{item}" }
puts "\n\n\n"

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
puts "tab.my_all?{ |word| word.length >= 3 } #=> #{my_all}\n\n"
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
puts "tab.my_any?{ |word| word.length >= 3 } #=> #{my_any}\n\n"
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
puts "Given the array elts = [2,4,5]\n\n"
digits = [2, 4, 5]
multiply = multiply_els(digits)
puts "multiply_els(digits) #=> #{multiply}"
