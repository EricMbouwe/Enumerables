require_relative '../enumerable.rb'

describe 'Enumerable' do
  describe '#my_each' do
    let(:arr) { [1, 8, 6, 2] }

    it 'should return all the elements of the array' do
      expect(arr.my_each { |x| x }).to eql([1, 8, 6, 2])
    end
    it 'should return all the elements of the array' do
      expect(arr.my_each { |x| x }).not_to eql([1, 8, 2])
    end
  end

  describe '#my_each_with_index' do
    let(:arr) { [1, 8, 6, 2] }

    it 'should return the array element with their index' do
      expect(arr.my_each_with_index { |x, i| puts }).to eql([0, 1, 2, 3])
    end
  end

  describe '#my_select' do
    let(:arr) { [1, 8, 6, 2] }

    it 'return the selected elements in the given proc' do
      expect(arr.my_select(&:even?)).to eql([8, 6, 2])
    end
    it 'return the selected elements in the given block' do
      expect(arr.my_select { |x| x > 2 }).to eql([8, 6])
    end
    it 'return the selected elements in the given block' do
      expect(arr.my_select { |x| x > 2 }).not_to eql([8, 6, 1])
    end
  end

  describe '#my_all?' do
    let(:tab) { %w[ant bear cat] }

    it 'check if all the array items match the given block' do
      expect(tab.my_all? { |word| word.length >= 3 }).to be(true)
    end
    it 'check if all the array items match the given block' do
      expect(tab.my_all? { |word| word.length >= 4 }).not_to be(true)
    end
    it 'check if all the array items match the given block' do
      expect(tab.my_all?(/t/)).not_to be(true)
    end
    it 'check if all the array items match the given block' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to be(true)
    end
    it 'check if all the array items match the given block' do
      expect([nil, true, 99].my_all?).not_to be(true)
    end
    it 'check if all the array items match the given block' do
      expect([].my_all?).to be(true)
    end
  end

  describe '#my_any?' do
    let(:tab) { %w[ant beart cat] }

    it 'check if any of the array items match the given block' do
      expect(tab.my_any? { |word| word.length >= 3 }).to be(true)
    end
    it 'check if any of the array items match the given block' do
      expect(tab.my_any? { |word| word.length > 5 }).not_to be(true)
    end
    it 'check if any of the array items match the given block' do
      expect(tab.my_any?(/n/)).to be(true)
    end
    it 'check if any of the array items match the given block' do
      expect([1, 2i, 3.14].my_any?(Numeric)).to be(true)
    end
    it 'check if any of the array items match the given block' do
      expect([nil, true, 99].my_any?).to be(true)
    end
    it 'check if any of the array items match the given block' do
      expect([].my_any?).not_to be(true)
    end
  end

  describe '#my_none?' do
    let(:tab) { %w[ant bear cat] }

    it 'check if none of the array items match the given block' do
      expect(tab.my_none? { |word| word.length == 5 }).to be(true)
    end
    it 'check if none of the array items match the given block' do
      expect(tab.my_none?(/d/)).to be(true)
    end
    it 'check if none of the array items match the given block' do
      expect([1, 2i, 3.14].my_none?(Float)).not_to be(true)
    end
    it 'check if none of the array items match the given block' do
      expect([nil, true, 99].my_none?).not_to be(true)
    end
    it 'check if none of the array items match the given block' do
      expect([].my_none?).to be(true)
    end
  end

  describe '#my_count' do
    let(:arr) { [1, 2, 4, 2] }

    it 'should return the number of item in the array' do
      expect(arr.my_count).to eql(4)
    end
    it 'should return the number of occurence of the given argument' do
      expect(arr.my_count(2)).to eql(2)
    end
    it 'should return the number of even items in the array' do
      expect(arr.my_count(&:even?)).to eql(3)
    end
  end

  describe '#my_map' do
    let(:arr) { [1, 8, 6, 2] }
    let(:arry) { (1..4) }
    let(:bob) { proc { |x| x + 5 } }
    let(:my_proc) { proc { |num| num > 10 } }

    it 'return a new array with the block instructions' do
      expect(arr.my_map { |x| x + 1 }).to eql([2, 9, 7, 3])
    end
    it 'return a new array with the given proc' do
      expect(arry.my_map(&bob)).to eql([6, 7, 8, 9])
    end
    it 'return a new array with the given proc when bloc and proc given' do
      expect([18, 22, 5, 6].my_map(my_proc) { |num| num < 10 }).to eql([true, true, false, false])
    end
  end

  describe '#my_inject' do
    let(:arr) { (5..10) }
    let(:my_proc) { proc { |product, n| product * n } }

    it 'return a result according to the arguments given' do
      expect(arr.my_inject(1, :*)).to eql(151_200)
    end
    it 'return the sum of all the element of the array ' do
      expect(arr.my_inject(:+)).to eql(45)
    end
    it 'return the sum of all the element of the array with an argument given ' do
      expect(arr.my_inject(:+)).not_to eql(40)
    end
    it 'return the sum of all the element of the array with a block given ' do
      expect(arr.my_inject { |sum, n| sum + n }).to eql(45)
    end
    it 'return a result with a proc given as argument' do
      expect(arr.my_inject(&my_proc)).to eql(151_200)
    end
  end
end
