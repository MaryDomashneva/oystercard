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

  def initialize(balance = 0, journey_history = [], current_journey = nil)
    @balance = balance
    @journey_history = journey_history
    @current_journey = current_journey
  end

  def top_up(amount)
    raise  ERROR_MESSAGES[:exceeded_limit] if limit_reached?(amount)
    @balance += amount
    return @balance
  end

  def touch_in(station)
    raise ERROR_MESSAGES[:minimum_fair] if !has_minimum?
    station.pass
    @current_journey = Journey.new
    @current_journey.entry_station = station
    @journey_history << @current_journey
    in_journey?
  end

  def touch_out(station)
    deduct(MINIMUM_FAIR)
    @current_journey.exit_station = station
    @journey_history[@journey_history.count - 1] = @current_journey
    @current_journey = nil
    in_journey?
  end

  def in_journey?
    return !@current_journey.nil?
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
