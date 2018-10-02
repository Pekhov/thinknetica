require_relative('wagon')

class CargoWagon < Wagon
  
  def initialize(volume)
    @max_volume = volume
    @free_volume = volume
    super('cargo')
  end

  def take_volume(volume)
    if @free_volume >= volume
      @free_volume -= volume
    else
      false
    end
  end

  def get_busy_volume
    @max_volume - @free_volume
  end

  def get_free_volume
    @free_volume
  end

end
