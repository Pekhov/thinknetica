class Station
  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end
  
  def add_train(train)
    @trains << train
  end
  
  def get_trains_in_station_by_type(type)
    @trains.count {|train| train.type == type}
  end
  
  def train_departure(train)
    @trains.delete(train) if train.current_station == self
  end

end
