import 'package:flutter/material.dart';
import '../data/vehicle_data.dart';
import '../models/truck.dart';
import '../models/engine.dart';
import '../models/enums.dart';

class TruckScreen extends StatefulWidget {
  const TruckScreen({super.key});

  @override
  State<TruckScreen> createState() => _TruckScreenState();
}

class _TruckScreenState extends State<TruckScreen> {
  final _searchController = TextEditingController();
  String _searchType = 'Company';

  List<Truck> get filteredTrucks {
    if (_searchController.text.isEmpty) return VehicleData.trucks;
    return VehicleData.trucks.where((t) {
      final query = _searchController.text.toLowerCase();
      if (_searchType == 'Company')
        return t.manufactureCompany.toLowerCase().contains(query);
      if (_searchType == 'Plate') return t.plateNum.toString().contains(query);
      if (_searchType == 'Date')
        return t.manufactureDate.toString().contains(query);
      return false;
    }).toList();
  }

  void _showTruckForm({Truck? truck, int? insertIndex}) {
    final _companyController =
        TextEditingController(text: truck?.manufactureCompany);
    final _modelController = TextEditingController(text: truck?.model);
    final _plateController =
        TextEditingController(text: truck?.plateNum.toString());
    final _lengthController =
        TextEditingController(text: truck?.length.toString());
    final _widthController =
        TextEditingController(text: truck?.width.toString());
    final _colorController = TextEditingController(text: truck?.color);
    final _freeWeightController =
        TextEditingController(text: truck?.freeWeight.toString());
    final _fullWeightController =
        TextEditingController(text: truck?.fullWeight.toString());
    final _dateController = TextEditingController(
        text: truck != null
            ? truck.manufactureDate.toString().split(' ')[0]
            : '');
    final _engineModelController =
        TextEditingController(text: truck?.engine.model);
    final _engineCapacityController =
        TextEditingController(text: truck?.engine.capacity.toString());

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(truck == null ? 'Add Truck' : 'Edit Truck'),
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
                    decoration:
                        const InputDecoration(labelText: 'Plate Number'),
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
                    controller: _freeWeightController,
                    decoration: const InputDecoration(labelText: 'Free Weight'),
                    keyboardType: TextInputType.number),
                TextField(
                    controller: _fullWeightController,
                    decoration: const InputDecoration(labelText: 'Full Weight'),
                    keyboardType: TextInputType.number),
                TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                        labelText: 'Manufacture Date (yyyy-mm-dd)')),
                TextField(
                    controller: _engineModelController,
                    decoration:
                        const InputDecoration(labelText: 'Engine Model')),
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
                final length = int.tryParse(_lengthController.text) ?? 0;
                final width = int.tryParse(_widthController.text) ?? 0;
                final freeWeight =
                    double.tryParse(_freeWeightController.text) ?? 0.0;
                final fullWeight =
                    double.tryParse(_fullWeightController.text) ?? 0.0;
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
                  int.tryParse(_engineCapacityController.text) ?? 0,
                  6,
                  FuelType.diesel,
                );

                if (truck == null) {
                  final newTruck = Truck.full(
                    _companyController.text,
                    manuDate,
                    _modelController.text,
                    eng,
                    plate,
                    GearType.automatic,
                    0,
                    length,
                    width,
                    _colorController.text,
                    freeWeight,
                    fullWeight,
                  );
                  if (insertIndex != null)
                    VehicleData.trucks.insert(insertIndex, newTruck);
                  else
                    VehicleData.trucks.add(newTruck);
                } else {
                  truck.manufactureCompany = _companyController.text;
                  truck.model = _modelController.text;
                  truck.plateNum = plate;
                  truck.length = length;
                  truck.width = width;
                  truck.color = _colorController.text;
                  truck.freeWeight = freeWeight;
                  truck.fullWeight = fullWeight;
                  truck.manufactureDate = manuDate;
                  truck.engine.model = _engineModelController.text;
                  truck.engine.capacity =
                      int.tryParse(_engineCapacityController.text) ?? 0;
                }

                await VehicleData.saveData();
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel')),
          ],
        );
      },
    );
  }

  void _printTruck(Truck t) {
    print('--- Truck ---');
    print(
        'Company: ${t.manufactureCompany}, Model: ${t.model}, Plate: ${t.plateNum}');
    print('Length: ${t.length}, Width: ${t.width}, Color: ${t.color}');
    print('Free Weight: ${t.freeWeight}, Full Weight: ${t.fullWeight}');
    print('Engine: ${t.engine.model}, Capacity: ${t.engine.capacity}');
    print('Manufacture Date: ${t.manufactureDate}');
    print('Body Serial Number: ${t.bodySerialNum}');
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
                onPressed: () => _showTruckForm(),
                child: const Text('Add Truck')),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () => _showTruckForm(insertIndex: 0),
                child: const Text('Insert at Top')),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredTrucks.length,
            itemBuilder: (context, index) {
              final t = filteredTrucks[index];
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
                              child: Text('${t.manufactureCompany} ${t.model}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))),
                          IconButton(
                              icon: const Icon(Icons.print),
                              onPressed: () => _printTruck(t)),
                        ],
                      ),
                      Text(
                          'Plate: ${t.plateNum}, Length: ${t.length}, Width: ${t.width}, Color: ${t.color}'),
                      Text(
                          'Free Weight: ${t.freeWeight}, Full Weight: ${t.fullWeight}'),
                      Text(
                          'Engine: ${t.engine.model}, Capacity: ${t.engine.capacity}'),
                      Text(
                          'Manufacture Date: ${t.manufactureDate.toString().split(' ')[0]}'),
                      Text('Body Serial Number: ${t.bodySerialNum}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showTruckForm(truck: t)),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                VehicleData.trucks.remove(t);
                                VehicleData.saveData();
                                setState(() {});
                              }),
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
