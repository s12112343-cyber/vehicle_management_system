import 'package:flutter/material.dart';
import 'screens/motorcycle_screen.dart';
import 'screens/car_screen.dart';
import 'screens/truck_screen.dart';
import 'data/vehicle_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await VehicleData.loadData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Management System',
      home: const VehicleHome(),
    );
  }
}

class VehicleHome extends StatelessWidget {
  const VehicleHome({super.key});

  void _printAllVehicles() {
    print('=== All Motorcycles ===');
    for (var m in VehicleData.motorcycles) {
      print('${m.manufactureCompany} ${m.model} Plate: ${m.plateNum}');
    }
    print('=== All Cars ===');
    for (var c in VehicleData.cars) {
      print('${c.manufactureCompany} ${c.model} Plate: ${c.plateNum}');
    }
    print('=== All Trucks ===');
    for (var t in VehicleData.trucks) {
      print('${t.manufactureCompany} ${t.model} Plate: ${t.plateNum}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vehicle Management System'),
          actions: [
            IconButton(
              icon: const Icon(Icons.print),
              onPressed: _printAllVehicles,
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Motorcycles'),
              Tab(text: 'Cars'),
              Tab(text: 'Trucks'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MotorcycleScreen(),
            CarScreen(),
            TruckScreen(),
          ],
        ),
      ),
    );
  }
}
