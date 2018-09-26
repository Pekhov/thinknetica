require_relative('station')
require_relative('route')
require_relative('train')
require_relative('wagon')
require_relative('cargo_wagon')
require_relative('passenger_wagon')
require_relative('passenger_train')
require_relative('cargo_train')

class Railway
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end
  
  MAIN_MENU = <<-EOF
  
Введите 1, для управления станциями
Введите 2, для управления маршрутами
Введите 3, для управления поездами
Введите 0, для выхода

  EOF
  
  def menu
    loop do
      print MAIN_MENU
      case gets.chomp.to_i
      when 1 then station_manager
      when 2 then route_manager
      when 3 then train_manager
      when 0 then break
      end
    end
  end
  
  private # Эти методы не будут вызываться из "вне" и не будут использоваться напрямую пользователем
  
  # Методы станций
  
  def station_manager
    print <<-EOF
\nВведите 1, для создания станции
Введите 2, для просмотра всех станций
Введите 3, для просмотра поездов на станции
Введите 0, для возврата в главное меню
    EOF
    case gets.chomp.to_i
    when 1 then create_station
    when 2 then show_all_stations
    when 3 then show_train_on_station
    when 0 then menu
    end
  end
  
  def create_station
    print "Введите название станции "
    @stations << Station.new(gets.chomp)
    puts "Создали станцию: #{@stations.last.name}"
  end
  
  def show_all_stations
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end
  
  def show_train_on_station
    select_station.trains.each {|train| puts "Поезд №#{train.number} - #{train.type}" }
  end
  
  
  # Методы поездов
  
  def train_manager
    print <<-EOF
\nВведите 1, если хотите создать поезд
Введите 2, если хотите назначить поезду маршрут
Введите 3, если хотите добавить поезду вагон
Введите 4, если хотите отцепить вагон
Введите 5, если хотите переместить поезд на следующую станцию
Введите 6, если хотите переместить поезд на предыдущую станцию
Введите 0, для возврата в главное меню
    EOF
    case gets.chomp.to_i
    when 1 then create_train
    when 2 then assign_route_to_train
    when 3 then add_wagon_to_train
    when 4 then remove_wagon_from_train
    when 5 then move_to_next_station
    when 6 then move_to_previous_station
    when 0 then menu
    end
  end
  
  def create_train
    print <<-EOF
Введите 1, если хотите создать пассажирский поезд
Введите 2, если хотите создать грузовой поезд
    EOF
    train_type = gets.chomp.to_i
    print "Введите номер поезда "
    number = gets.chomp.to_i
    if train_type == 1
      @trains << PassengerTrain.new(number)
      puts "Создали пассажирский поезд с номером: #{@trains.last.number}"
    elsif train_type == 2
      @trains << CargoTrain.new(number)
      puts "Создали грузовой поезд с номером: #{@trains.last.number}"
    end
  end
  
  def assign_route_to_train
    if @trains.any? and @routes.any?
      select_train.set_route(select_route)
      puts "Назначили поезду маршрут"
    else
      puts "Сначала нужно создать поезда и маршруты"
    end
  end
  
  def add_wagon_to_train
    train = select_train
    if train.type == 'passenger'
      wagon = PassengerWagon.new
      train.add_wagon(wagon)
    else
      wagon = CargoWagon.new
      train.add_wagon(wagon)
    end
    puts "Прицепили вагон"
  end
  
  def remove_wagon_from_train
    train = select_train
    if train.wagons.any?
      train.remove_wagon(train.wagons.last)
      puts "Отцепили вагон"
    else
      puts "У поезда нет вагонов"
    end
  end
  
  def move_to_next_station
    train = select_train
    if train.route
      train.go_to_next_station
      puts "Переместили поезд"
    else
      puts "Поезду не назначен маршрут"
    end
  end
  
  def move_to_previous_station
    train = select_train
    if train.route
      train.go_to_previous_station
      puts "Переместили поезд"
    else
      puts "Поезду не назначен маршрут"
    end
  end
  
  # Методы маршрутов
  
  def route_manager
    print <<-EOF
\nВведите 1, если хотите создать маршрут
Введите 2, если хотите добавить станцию в маршрут
Введите 3, если хотите удалить станцию
Введите 4, если хотите просмотреть станции в маршруте
Введите 0, для возврата в главное меню
    EOF
    case gets.chomp.to_i
    when 1 then create_route
    when 2 then add_station_to_route
    when 3 then delete_station_from_route
    when 4 then show_station_in_route
    when 0 then menu
    end
  end
  
  def create_route
    if @stations.count > 1
      puts "Введите начальную станцию маршрута"
      start_station = select_station
      puts "Введите конечную станцию маршрута"
      end_station = select_station
      @routes << Route.new(start_station, end_station)
      puts "Создали маршрут"
    else
      puts "Недостаточно станций для создания маршрута"
      menu
    end
  end
  
  def add_station_to_route
    if @stations.any? and @routes.any?
      select_route.add_station(select_station)
      puts "Добавили станцию к маршруту"
    else
      puts "Сначала заведите новые станции и маршруты"
      menu
    end
  end
  
  def delete_station_from_route
    if @stations.any? and @routes.any?
      route = select_route
      if route.delete_station(select_route_station(route))
        puts "Удалили станцию из маршрута"
      else
        puts "Невозможно удалить станцию"
      end
    else
      puts "Сначала заведите новые станции и маршруты"
      menu
    end
  end
  
  def show_station_in_route
    select_route.show_stations
  end
  
  # Общие методы
  
  def select_route_station(route)
    print "Введите порядковый номер станции:"
    route.show_stations
    route.stations[gets.chomp.to_i - 1]
  end
  
  def select_station
    print "Введите порядковый номер станции:"
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
    @stations[gets.chomp.to_i - 1]
  end
  
  def select_route
    @routes.each.with_index(1) do |route, index|
      print "Введите порядковый номер маршрута:"
      puts "#{index} - Маршрут #{route.stations.first.name} - #{route.stations.last.name}"
    end
    @routes[gets.chomp.to_i - 1]
  end
  
  def select_train
    print "Введите порядковый номер поезда:"
    @trains.each.with_index(1) do |train, index|
      puts "#{index} - Поезд №#{train.number} - #{train.type}"
    end
    @trains[gets.chomp.to_i - 1]
  end
end
rr = Railway.new
rr.menu
