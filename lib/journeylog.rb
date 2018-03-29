require_relative './oystercard'

class JourneyLog
  def initialize(journey_history = [])
    @journey_history = journey_history
  end

  def add_journey(journey)
    @journey_history << journey
  end

  def update_last_journey(journey)
    @journey_history[@journey_history.count - 1] = journey
  end

  def last
    @journey_history.last
  end
end
