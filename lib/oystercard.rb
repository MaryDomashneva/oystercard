class Oystercard
  attr_reader :balance
  DEFAULT_CAPACITY = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    raise 'The amount you are trying to top up is above limit = 90' if amount > DEFAULT_CAPACITY
    @balance += amount
    return @balance
  end
end
