import 'automobile.dart';

class Vehicle extends Automobile {
  int _length = 0;
  int _width = 0;
  String _color = '';

  int get length => _length;
  set length(int value) => _length = value;

  int get width => _width;
  set width(int value) => _width = value;

  String get color => _color;
  set color(String value) => _color = value;

  Vehicle();
  Vehicle.full(
    String manufactureCompany,
    DateTime manufactureDate,
    String model,
    engine,
    int plateNum,
    gearType,
    int bodySerialNum,
    this._length,
    this._width,
    this._color,
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
    json.addAll({'length': _length, 'width': _width, 'color': _color});
    return json;
  }
}
