import 'vehicle.dart';
import 'engine.dart';
import 'enums.dart';

class Car extends Vehicle {
  int _chairNum = 0;
  bool _isFurnitureLeather = false;

  int get chairNum => _chairNum;
  set chairNum(dynamic value) => _chairNum = (value ?? 0);

  bool get isFurnitureLeather => _isFurnitureLeather;
  set isFurnitureLeather(dynamic value) =>
      _isFurnitureLeather = (value ?? false);

  Car();

  Car.full(
    String manufactureCompany,
    DateTime manufactureDate,
    String model,
    Engine engine,
    int plateNum,
    GearType gearType,
    int bodySerialNum,
    int length,
    int width,
    String color,
    int chairNum,
    bool isFurnitureLeather,
  ) : _chairNum = chairNum,
      _isFurnitureLeather = isFurnitureLeather,
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

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['chairNum'] = _chairNum;
    json['isFurnitureLeather'] = _isFurnitureLeather;
    return json;
  }

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
      json['length'] ?? 0,
      json['width'] ?? 0,
      json['color'] ?? '',
      (json['chairNum'] ?? 0),
      (json['isFurnitureLeather'] ?? false),
    );
  }
}
