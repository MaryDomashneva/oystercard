require_relative './oystercard'

class FareCalculator

  BOUNDARY_CROSSED = 1
  PENALTY_CHARGE = 6
  MINIMUM_FAIR = 1

  def calculator(journey)
      amount = MINIMUM_FAIR
      amount += PENALTY_CHARGE unless journey.complete?
      amount += BOUNDARY_CROSSED * cross_border(journey) if journey.complete?
      amount
  end

  def cross_border(journey)
    (journey.entry_station.zone - journey.exit_station.zone).abs
  end
end
