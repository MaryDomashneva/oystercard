require_relative 'station'
require_relative 'journey'
require_relative 'fare_calculator'

class Oystercard
  attr_reader :balance
  attr_reader :current_journey
  attr_reader :journey_history

  DEFAULT_CAPACITY = 90
  MINIMUM_FAIR = 1
  ERROR_MESSAGES = {
    exceeded_limit: 'The amount you are trying to top up is above limit = 90 GBR',
    minimum_fair: 'Minimum amount to start a journey is 1 GBR'
  }.freeze

  def initialize(balance = 0, journey_history = [], current_journey = nil, fare_calculator = FareCalculator.new)
    @balance = balance
    @journey_history = journey_history
    @current_journey = current_journey
    @fare_calculator = fare_calculator
  end

  def top_up(amount)
    raise ERROR_MESSAGES[:exceeded_limit] if limit_reached?(amount)
    @balance += amount
    @balance
  end

  def touch_in(station)
    raise ERROR_MESSAGES[:minimum_fair] unless has_minimum?
    station.pass
    @current_journey = Journey.new
    @current_journey.entry_station = station
    @journey_history << @current_journey
    in_journey?
  end

  def touch_out(station)
    @current_journey.exit_station = station
    @journey_history[@journey_history.count - 1] = @current_journey
    amount = @fare_calculator.calculator(@current_journey)
    deduct(amount)
    @current_journey = nil
    in_journey?
  end

  def in_journey?
    !@current_journey.nil?
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
    @balance
  end
end
