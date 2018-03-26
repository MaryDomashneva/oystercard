class Oystercard
  attr_reader :balance
  DEFAULT_CAPACITY = 90
  ERROR_MESSAGES = {
    :exceeded_limit => 'The amount you are trying to top up is above limit = 90'
  }

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    raise  ERROR_MESSAGES[:exceeded_limit] if limit_reached?(amount)
    @balance += amount
    return @balance
  end

  def deduct(amount)
    @balance -= amount
    return @balance
  end

  private

  def limit_reached?(amount)
    @balance + amount > DEFAULT_CAPACITY
  end


end
