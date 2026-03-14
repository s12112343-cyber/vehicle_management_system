import 'engine.dart';
import 'enums.dart';

class Vehicle {
  String manufactureCompany = '';
  DateTime manufactureDate = DateTime.now();
  String model = '';
  Engine engine = Engine();
  int plateNum = 0;
  GearType gearType = GearType.normal;
  int bodySerialNum = 0;
  double length = 0.0; // ✅ double
  double width = 0.0; // ✅ double
  String color = '';

  Vehicle();

  Vehicle.full(
    this.manufactureCompany,
    this.manufactureDate,
    this.model,
    this.engine,
    this.plateNum,
    this.gearType,
    this.bodySerialNum,
    this.length,
    this.width,
    this.color,
  );

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle.full(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'manufactureCompany': manufactureCompany,
      'manufactureDate': manufactureDate.toIso8601String(),
      'model': model,
      'engine': engine.toJson(),
      'plateNum': plateNum,
      'gearType': gearType.toString().split('.').last,
      'bodySerialNum': bodySerialNum,
      'length': length,
      'width': width,
      'color': color,
    };
  }
}
