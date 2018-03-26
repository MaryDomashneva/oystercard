class Oystercard
  attr_reader :balance
  DEFAULT_CAPACITY = 0

  def initialize(balance = DEFAULT_CAPACITY)
    @balance = balance
  end

  def top_up(amount)
    @balance += amount
    return @balance
  end
end
