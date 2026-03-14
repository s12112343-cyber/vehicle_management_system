import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/motorcycle.dart';
import '../models/car.dart';
import '../models/truck.dart';

class VehicleData {
  static List<Motorcycle> motorcycles = [];
  static List<Car> cars = [];
  static List<Truck> trucks = [];

  static Future<String> getFilePath(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$filename';
  }

  static Future<void> saveData() async {
    final motoFile = await getFilePath('motorcycles.json');
    final carFile = await getFilePath('cars.json');
    final truckFile = await getFilePath('trucks.json');

    await File(motoFile)
        .writeAsString(jsonEncode(motorcycles.map((e) => e.toJson()).toList()));
    await File(carFile)
        .writeAsString(jsonEncode(cars.map((e) => e.toJson()).toList()));
    await File(truckFile)
        .writeAsString(jsonEncode(trucks.map((e) => e.toJson()).toList()));
  }

  static Future<void> loadData() async {
    final motoFile = await getFilePath('motorcycles.json');
    final carFile = await getFilePath('cars.json');
    final truckFile = await getFilePath('trucks.json');

    if (File(motoFile).existsSync()) {
      final data = jsonDecode(File(motoFile).readAsStringSync()) as List;
      motorcycles = data.map((e) => Motorcycle.fromJson(e)).toList();
    }
    if (File(carFile).existsSync()) {
      final data = jsonDecode(File(carFile).readAsStringSync()) as List;
      cars = data.map((e) => Car.fromJson(e)).toList();
    }
    if (File(truckFile).existsSync()) {
      final data = jsonDecode(File(truckFile).readAsStringSync()) as List;
      trucks = data.map((e) => Truck.fromJson(e)).toList();
    }
  }
}
