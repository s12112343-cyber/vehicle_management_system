import 'automobile.dart';

import 'engine.dart';
import 'enums.dart';

class Motorcycle extends Automobile {
  double _tierDiameter = 0.0;
  double _length = 0.0;

  double get tierDiameter => _tierDiameter;
  set tierDiameter(double value) => _tierDiameter = value;

  double get length => _length;
  set length(double value) => _length = value;

  Motorcycle();
  Motorcycle.full(
    String manufactureCompany,
    DateTime manufactureDate,
    String model,
    engine,
    int plateNum,
    gearType,
    int bodySerialNum,
    this._tierDiameter,
    this._length,
  ) : super.full(
        manufactureCompany,
        manufactureDate,
        model,
        engine,
        plateNum,
        gearType,
        bodySerialNum,
      );

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({'tierDiameter': _tierDiameter, 'length': _length});
    return json;
  }

  factory Motorcycle.fromJson(Map<String, dynamic> json) {
    return Motorcycle.full(
      json['manufactureCompany'],
      DateTime.parse(json['manufactureDate']),
      json['model'],
      Engine.fromJson(json['engine']),
      json['plateNum'],
      GearType.values.firstWhere(
        (e) => e.toString() == 'GearType.${json['gearType']}',
      ),
      json['bodySerialNum'],
      json['tierDiameter'],
      json['length'],
    );
  }
}
