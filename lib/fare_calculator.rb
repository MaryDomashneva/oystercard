require 'oystercard'

class FareCalculator
  attr_accessor :fair

  BOUNDARY_CROSSED = 1
  PENALTY_CHARGE = 6

  def calculator(journey)
    amount = MINIMUM_FAIR
    amount += PENALTY_CHARGE if !journey.complete?
    amount += BOUNDARY_CROSSED * cross_border(journey) if journey.complete?
    return amount
  end

  def cross_border(journey)
    (journey.entry_station.zone - journey.exit_station.zone).abs
  end
end
