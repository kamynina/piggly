module Enumerable

  def count
    if block_given?
      inject(0){|count, x| count + (yield(x) ? 1 : 0) }
    else
      size
    end
  end unless method_defined?(:count)

  def sum(init = 0)
    if block_given?
      inject(init){|sum, e| sum + yield(e) }
    else
      inject(init){|sum, e| sum + e }
    end
  end unless method_defined?(:sum)

  def group_by(collection = Hash.new{|h,k| h[k] = [] })
    inject(collection) do |hash, item|
      hash[yield(item)] << item
      hash
    end
  end unless method_defined?(:group_by)

end