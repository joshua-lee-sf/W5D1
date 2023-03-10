require 'byebug'

class MaxIntSet
  attr_reader :store
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    # @store << num
    raise "Out of bounds" if num > @max || num < 0
    # if !@store.include?(num)
    if @store[num] == false
      @store[num] = true 
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    if @store[num] == true
      true
    else  
      false
    end
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    if self[num].include?(num)
      true
    else
      false
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self[num].include?(num) #&& count == 0
      self[num] << num
      self.count += 1
      true
    end
    if self.count > self.num_buckets
      self.resize!
    end

  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      self.count -= 1
    end
  end

  def inspect
    @store
  end

  def include?(num)
    if self[num].include?(num)
      true
    else
      false
    end
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    dupped = @store.flatten
    # prev_num_buckets = count
    if dupped.length > self.num_buckets
      @store = Array.new(self.num_buckets *= 2) {Array.new}
      dupped.each do |el|
        @store[el] << el
      end
    end
    @store
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % self.num_buckets] 
  end
end