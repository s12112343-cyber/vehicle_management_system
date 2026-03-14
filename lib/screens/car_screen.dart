import 'package:flutter/material.dart';
import '../bloc/vehicle_bloc.dart';
import '../data/vehicle_data.dart';
import '../models/car.dart';
import '../models/engine.dart';
import '../models/enums.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final _searchController = TextEditingController();
  String _searchType = 'Company';
  VehicleBloc vehicleBloc = VehicleBloc();

  List<Car> get filteredCars {
    if (_searchController.text.isEmpty) return vehicleBloc.cars;
    return vehicleBloc.cars.where((c) {
      final query = _searchController.text.toLowerCase();
      if (_searchType == 'Company')
        return c.manufactureCompany.toLowerCase().contains(query);
      if (_searchType == 'Plate') return c.plateNum.toString().contains(query);
      if (_searchType == 'Date')
        return c.manufactureDate.toString().contains(query);
      return false;
    }).toList();
  }

  void _showCarForm({Car? car, int? insertIndex}) {
    final _companyController =
        TextEditingController(text: car?.manufactureCompany);
    final _modelController = TextEditingController(text: car?.model);
    final _plateController =
        TextEditingController(text: car?.plateNum.toString());
    final _lengthController =
        TextEditingController(text: car?.length.toString());
    final _widthController = TextEditingController(text: car?.width.toString());
    final _colorController = TextEditingController(text: car?.color);
    final _dateController = TextEditingController(
        text: car != null ? car.manufactureDate.toString().split(' ')[0] : '');
    final _engineModelController =
        TextEditingController(text: car?.engine.model);
    final _engineCapacityController =
        TextEditingController(text: car?.engine.capacity.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(car == null ? 'Add Car' : 'Edit Car'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: _companyController,
                  decoration: const InputDecoration(labelText: 'Company')),
              TextField(
                  controller: _modelController,
                  decoration: const InputDecoration(labelText: 'Model')),
              TextField(
                  controller: _plateController,
                  decoration: const InputDecoration(labelText: 'Plate Number'),
                  keyboardType: TextInputType.number),
              TextField(
                  controller: _lengthController,
                  decoration: const InputDecoration(labelText: 'Length'),
                  keyboardType: TextInputType.number),
              TextField(
                  controller: _widthController,
                  decoration: const InputDecoration(labelText: 'Width'),
                  keyboardType: TextInputType.number),
              TextField(
                  controller: _colorController,
                  decoration: const InputDecoration(labelText: 'Color')),
              TextField(
                  controller: _dateController,
                  decoration:
                      const InputDecoration(labelText: 'Manufacture Date')),
              TextField(
                  controller: _engineModelController,
                  decoration: const InputDecoration(labelText: 'Engine Model')),
              TextField(
                  controller: _engineCapacityController,
                  decoration:
                      const InputDecoration(labelText: 'Engine Capacity'),
                  keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final plate = int.tryParse(_plateController.text) ?? 0;
              final length = double.tryParse(_lengthController.text) ?? 0.0;
              final width = double.tryParse(_widthController.text) ?? 0.0;
              final engineCapacity =
                  int.tryParse(_engineCapacityController.text) ?? 0;

              DateTime manuDate;
              try {
                manuDate = DateTime.parse(_dateController.text);
              } catch (_) {
                manuDate = DateTime.now();
              }

              final eng = Engine.full(
                _companyController.text,
                manuDate,
                _engineModelController.text,
                engineCapacity,
                4,
                FuelType.gasoline,
              );

              if (car == null) {
                final newCar = Car.full(
                  _companyController.text,
                  manuDate,
                  _modelController.text,
                  eng,
                  plate,
                  GearType.automatic,
                  4,
                  length,
                  width,
                  _colorController.text,
                );
                if (insertIndex != null) {
                  vehicleBloc.insertCar(insertIndex, newCar);
                } else {
                  vehicleBloc.addCar(newCar);
                }
              } else {
                car.manufactureCompany = _companyController.text;
                car.model = _modelController.text;
                car.plateNum = plate;
                car.length = length; // double مباشرة
                car.width = width; // double مباشرة
                car.color = _colorController.text;
                car.manufactureDate = manuDate;
                car.engine.model = _engineModelController.text;
                car.engine.capacity = engineCapacity;
              }

              await VehicleData.saveData();
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                    labelText: 'Search', prefixIcon: Icon(Icons.search)),
                onChanged: (_) => setState(() {}),
              ),
            ),
            DropdownButton<String>(
              value: _searchType,
              items: const [
                DropdownMenuItem(value: 'Company', child: Text('Company')),
                DropdownMenuItem(value: 'Plate', child: Text('Plate Number')),
                DropdownMenuItem(
                    value: 'Date', child: Text('Manufacture Date')),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _searchType = v);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () => _showCarForm(), child: const Text('Add Car')),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () => _showCarForm(insertIndex: 0),
                child: const Text('Insert at Top')),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCars.length,
            itemBuilder: (context, index) {
              final c = filteredCars[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text('${c.manufactureCompany} ${c.model}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showCarForm(car: c)),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              vehicleBloc
                                  .deleteCar(vehicleBloc.cars.indexOf(c));
                              VehicleData.saveData();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
