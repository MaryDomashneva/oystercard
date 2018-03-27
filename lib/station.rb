require_relative 'oystercard'

class Station
  def initialize(access = false)
    @access = access
  end

  def pass
    @access = true
  end

  def reject
    @access = false
  end
end
