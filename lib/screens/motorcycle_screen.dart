import 'package:flutter/material.dart';
import '../data/vehicle_data.dart';
import '../models/motorcycle.dart';
import '../models/engine.dart';
import '../models/enums.dart';

class MotorcycleScreen extends StatefulWidget {
  const MotorcycleScreen({super.key});

  @override
  State<MotorcycleScreen> createState() => _MotorcycleScreenState();
}

class _MotorcycleScreenState extends State<MotorcycleScreen> {
  final _searchController = TextEditingController();
  String _searchType = 'Company';

  List<Motorcycle> get filteredMotorcycles {
    if (_searchController.text.isEmpty) return VehicleData.motorcycles;
    return VehicleData.motorcycles.where((m) {
      final query = _searchController.text.toLowerCase();
      if (_searchType == 'Company')
        return m.manufactureCompany.toLowerCase().contains(query);
      if (_searchType == 'Plate') return m.plateNum.toString().contains(query);
      if (_searchType == 'Date')
        return m.manufactureDate.toString().contains(query);
      return false;
    }).toList();
  }

  void _showMotorcycleForm({Motorcycle? motorcycle, int? insertIndex}) {
    final _companyController =
        TextEditingController(text: motorcycle?.manufactureCompany);
    final _modelController = TextEditingController(text: motorcycle?.model);
    final _plateController =
        TextEditingController(text: motorcycle?.plateNum.toString());
    final _tierController =
        TextEditingController(text: motorcycle?.tierDiameter.toString());
    final _lengthController =
        TextEditingController(text: motorcycle?.length.toString());
    final _dateController = TextEditingController(
        text: motorcycle != null
            ? motorcycle.manufactureDate.toString().split(' ')[0]
            : '');
    final _engineModelController =
        TextEditingController(text: motorcycle?.engine.model);
    final _engineCapacityController =
        TextEditingController(text: motorcycle?.engine.capacity.toString());

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title:
              Text(motorcycle == null ? 'Add Motorcycle' : 'Edit Motorcycle'),
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
                    controller: _tierController,
                    decoration:
                        const InputDecoration(labelText: 'Tier Diameter'),
                    keyboardType: TextInputType.number),
                TextField(
                    controller: _lengthController,
                    decoration: const InputDecoration(labelText: 'Length'),
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
                final tier = double.tryParse(_tierController.text) ?? 0.0;
                final length = double.tryParse(_lengthController.text) ?? 0.0;
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
                  2,
                  FuelType.gasoline,
                );

                if (motorcycle == null) {
                  final newMoto = Motorcycle.full(
                    _companyController.text,
                    manuDate,
                    _modelController.text,
                    eng,
                    plate,
                    GearType.automatic,
                    0,
                    tier,
                    length,
                  );
                  if (insertIndex != null)
                    VehicleData.motorcycles.insert(insertIndex, newMoto);
                  else
                    VehicleData.motorcycles.add(newMoto);
                } else {
                  motorcycle.manufactureCompany = _companyController.text;
                  motorcycle.model = _modelController.text;
                  motorcycle.plateNum = plate;
                  motorcycle.tierDiameter = tier;
                  motorcycle.length = length;
                  motorcycle.manufactureDate = manuDate;
                  motorcycle.engine.model = _engineModelController.text;
                  motorcycle.engine.capacity =
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

  void _printMotorcycle(Motorcycle m) {
    print('--- Motorcycle ---');
    print(
        'Company: ${m.manufactureCompany}, Model: ${m.model}, Plate: ${m.plateNum}');
    print('Tier Diameter: ${m.tierDiameter}, Length: ${m.length}');
    print('Engine: ${m.engine.model}, Capacity: ${m.engine.capacity}');
    print('Manufacture Date: ${m.manufactureDate}');
    print('Body Serial Number: ${m.bodySerialNum}');
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
                onPressed: () => _showMotorcycleForm(),
                child: const Text('Add Motorcycle')),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () => _showMotorcycleForm(insertIndex: 0),
                child: const Text('Insert at Top')),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredMotorcycles.length,
            itemBuilder: (context, index) {
              final m = filteredMotorcycles[index];
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
                              child: Text('${m.manufactureCompany} ${m.model}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))),
                          IconButton(
                              icon: const Icon(Icons.print),
                              onPressed: () => _printMotorcycle(m)),
                        ],
                      ),
                      Text(
                          'Plate: ${m.plateNum}, Tier Diameter: ${m.tierDiameter}, Length: ${m.length}'),
                      Text(
                          'Engine: ${m.engine.model}, Capacity: ${m.engine.capacity}'),
                      Text(
                          'Manufacture Date: ${m.manufactureDate.toString().split(' ')[0]}'),
                      Text('Body Serial Number: ${m.bodySerialNum}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showMotorcycleForm(motorcycle: m)),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                VehicleData.motorcycles.remove(m);
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
