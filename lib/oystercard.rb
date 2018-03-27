require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance
  attr_reader :status
  attr_reader :journey_history
  DEFAULT_CAPACITY = 90
  MINIMUM_FAIR = 1
  ERROR_MESSAGES = {
    :exceeded_limit => 'The amount you are trying to top up is above limit = 90 GBR',
    :minimum_fair => 'Minimum amount to start a journey is 1 GBR'
  }

  def initialize(balance = 0, status = false, journey_history = {:entry => [], :exit_station => []})
    @balance = balance
    @status = status
    @station = nil
    @journey_history = journey_history
    @entry_array = []
    @exit_array = []
  end

  def top_up(amount)
    raise  ERROR_MESSAGES[:exceeded_limit] if limit_reached?(amount)
    @balance += amount
    return @balance
  end

  def touch_in(station)
    raise ERROR_MESSAGES[:minimum_fair] if !has_minimum?
    station.pass
    @entry_array << station
    @journey_history[:entry] = @entry_array
    @status = true
  end

  def touch_out(station)
    deduct(MINIMUM_FAIR)
    @exit_array << station
    @journey_history[:exit_station] = @exit_array #write a test
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
