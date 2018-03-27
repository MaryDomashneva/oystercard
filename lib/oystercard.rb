require_relative 'station'

class Oystercard
  attr_reader :balance
  DEFAULT_CAPACITY = 90
  MINIMUM_FAIR = 1
  ERROR_MESSAGES = {
    :exceeded_limit => 'The amount you are trying to top up is above limit = 90 GBR',
    :minimum_fair => 'Minimum amount to start a journey is 1 GBR'
  }

  def initialize(balance = 0, status = false)
    @balance = balance
    @status = status
  end

  def top_up(amount)
    raise  ERROR_MESSAGES[:exceeded_limit] if limit_reached?(amount)
    @balance += amount
    return @balance
  end



  def touch_in
    raise ERROR_MESSAGES[:minimum_fair] if !has_minimum?
    @status = true
  end

  def touch_out
    deduct(MINIMUM_FAIR)
    @status = false
  end

  def in_journey?
    return @status
  end



  private

  def limit_reached?(amount)
    @balance + amount > DEFAULT_CAPACITY
  end

  def has_minimum?
    @balance >= MINIMUM_FAIR
  end
  
  def deduct(amount)
    @balance -= amount
    return @balance
  end

end
