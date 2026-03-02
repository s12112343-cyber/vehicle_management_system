import 'enums.dart';

class Engine {
  String _manufacture = '';
  DateTime _manufactureDate = DateTime.now();
  String _model = '';
  int _capacity = 0;
  int _cylinders = 0;
  FuelType _fuelType = FuelType.gasoline;

  // Getters and Setters
  String get manufacture => _manufacture;
  set manufacture(String value) => _manufacture = value;

  DateTime get manufactureDate => _manufactureDate;
  set manufactureDate(DateTime value) => _manufactureDate = value;

  String get model => _model;
  set model(String value) => _model = value;

  int get capacity => _capacity;
  set capacity(int value) => _capacity = value;

  int get cylinders => _cylinders;
  set cylinders(int value) => _cylinders = value;

  FuelType get fuelType => _fuelType;
  set fuelType(FuelType value) => _fuelType = value;

  // Constructors
  Engine();
  Engine.full(
    this._manufacture,
    this._manufactureDate,
    this._model,
    this._capacity,
    this._cylinders,
    this._fuelType,
  );

  // JSON serialization
  Map<String, dynamic> toJson() => {
    'manufacture': _manufacture,
    'manufactureDate': _manufactureDate.toIso8601String(),
    'model': _model,
    'capacity': _capacity,
    'cylinders': _cylinders,
    'fuelType': _fuelType.toString().split('.').last,
  };

  factory Engine.fromJson(Map<String, dynamic> json) {
    return Engine.full(
      json['manufacture'],
      DateTime.parse(json['manufactureDate']),
      json['model'],
      json['capacity'],
      json['cylinders'],
      FuelType.values.firstWhere(
        (e) => e.toString() == 'FuelType.${json['fuelType']}',
      ),
    );
  }
}
