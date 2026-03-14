import 'vehicle.dart';
import 'engine.dart';
import 'enums.dart';

class Truck extends Vehicle {
  double _freeWeight = 0.0;
  double _fullWeight = 0.0;

  double get freeWeight => _freeWeight;
  set freeWeight(dynamic value) => _freeWeight =
      (value is int) ? value.toDouble() : (value is double ? value : 0.0);

  double get fullWeight => _fullWeight;
  set fullWeight(dynamic value) => _fullWeight =
      (value is int) ? value.toDouble() : (value is double ? value : 0.0);

  Truck();

  Truck.full(
    String manufactureCompany,
    DateTime manufactureDate,
    String model,
    Engine engine,
    int plateNum,
    GearType gearType,
    int bodySerialNum,
    double length, // ✅ double
    double width, // ✅ double
    String color,
    double freeWeight,
    double fullWeight,
  )   : _freeWeight = freeWeight,
        _fullWeight = fullWeight,
        super.full(
          manufactureCompany,
          manufactureDate,
          model,
          engine,
          plateNum,
          gearType,
          bodySerialNum,
          length,
          width,
          color,
        );

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck.full(
      json['manufactureCompany'] ?? '',
      DateTime.tryParse(json['manufactureDate'] ?? '') ?? DateTime.now(),
      json['model'] ?? '',
      Engine.fromJson(json['engine'] ?? {}),
      json['plateNum'] ?? 0,
      GearType.values.firstWhere(
        (e) => e.toString() == 'GearType.${json['gearType'] ?? 'normal'}',
        orElse: () => GearType.normal,
      ),
      json['bodySerialNum'] ?? 0,
      (json['length'] is int)
          ? (json['length'] as int).toDouble()
          : (json['length'] is double ? json['length'] : 0.0),
      (json['width'] is int)
          ? (json['width'] as int).toDouble()
          : (json['width'] is double ? json['width'] : 0.0),
      json['color'] ?? '',
      (json['freeWeight'] is int)
          ? (json['freeWeight'] as int).toDouble()
          : (json['freeWeight'] is double ? json['freeWeight'] : 0.0),
      (json['fullWeight'] is int)
          ? (json['fullWeight'] as int).toDouble()
          : (json['fullWeight'] is double ? json['fullWeight'] : 0.0),
    );
  }

  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['freeWeight'] = _freeWeight;
    json['fullWeight'] = _fullWeight;
    return json;
  }
}
