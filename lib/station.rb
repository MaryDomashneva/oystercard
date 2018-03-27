require_relative 'oystercard'

class Station
  attr_accessor :zone

  def initialize(access = false, zone = nil)
    @access = access
    @zone = zone
  end

  def pass
    @access = true
  end

  def reject
    @access = false
  end
end
