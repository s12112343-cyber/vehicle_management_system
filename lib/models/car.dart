import 'vehicle.dart';
import 'engine.dart';
import 'enums.dart';

class Car extends Vehicle {
  Car();

  Car.full(
    String manufactureCompany,
    DateTime manufactureDate,
    String model,
    Engine engine,
    int plateNum,
    GearType gearType,
    int bodySerialNum,
    double length, // double
    double width, // double
    String color,
  ) : super.full(
          manufactureCompany,
          manufactureDate,
          model,
          engine,
          plateNum,
          gearType,
          bodySerialNum,
          length, // مباشرة double
          width,
          color,
        );

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car.full(
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
          : (json['length'] ?? 0.0),
      (json['width'] is int)
          ? (json['width'] as int).toDouble()
          : (json['width'] ?? 0.0),
      json['color'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final json = super.toJson();
    return json;
  }
}
