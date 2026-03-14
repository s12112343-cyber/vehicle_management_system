import '../models/car.dart';
import '../models/truck.dart';
import '../models/motorcycle.dart';

class VehicleBloc {
  List<Car> cars = [];
  List<Truck> trucks = [];
  List<Motorcycle> motorcycles = [];

  // Add
  void addCar(Car car) => cars.add(car);
  void addTruck(Truck truck) => trucks.add(truck);
  void addMotorcycle(Motorcycle m) => motorcycles.add(m);

  // Delete
  void deleteCar(int index) => cars.removeAt(index);
  void deleteTruck(int index) => trucks.removeAt(index);
  void deleteMotorcycle(int index) => motorcycles.removeAt(index);

  // Insert
  void insertCar(int index, Car car) => cars.insert(index, car);
  void insertTruck(int index, Truck truck) => trucks.insert(index, truck);
  void insertMotorcycle(int index, Motorcycle m) =>
      motorcycles.insert(index, m);

  // Search
  List<Car> searchCarByCompany(String company) =>
      cars.where((c) => c.manufactureCompany == company).toList();

  List<Car> searchCarByPlate(int plate) =>
      cars.where((c) => c.plateNum == plate).toList();
}
