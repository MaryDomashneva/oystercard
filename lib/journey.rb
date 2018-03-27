require_relative 'oystercard'

class Journey
  attr_accessor :entry_station
  attr_accessor :exit_station

  def initialize(entry_station = nil, exit_station = nil)
    self.entry_station = entry_station
    self.exit_station = exit_station
  end
end
