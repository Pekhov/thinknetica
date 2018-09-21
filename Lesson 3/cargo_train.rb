require_relative('train')

class CargoTrain < Train
  def add_wagon(wagon)
    self.wagons << wagon if self.type == 'cargo_train'
  end
  
  def remove_wagon(wagon)
    self.wagons.delete(wagon) if self.speed == 0 && self.wagons.size > 1
  end
end