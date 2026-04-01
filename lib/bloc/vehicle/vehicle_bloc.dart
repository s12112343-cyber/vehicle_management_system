import 'dart:async';

import 'package:flutter_application_1/models/engine.dart';
import 'package:flutter_application_1/models/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../exceptions/vehicle_exceptions.dart';
import '../../../models/automobile.dart';
import '../../../models/car.dart';
import '../../../models/motorcycle.dart';
import '../../../models/truck.dart';
import '../../../repositories/vehicle_repository.dart';
import '../../../services/vehicle_api_service.dart';
import '../../../services/cache_service.dart';
import 'vehicle_event.dart';
import 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepository repository;
  final VehicleApiService apiService;
  final CacheService cacheService;
  Timer? _pollingTimer;

  // For testing without API - toggle to true to use demo data
  static const bool useDemoData = true;

  VehicleBloc({
    required this.repository,
    required this.apiService,
    required this.cacheService,
  }) : super(VehicleInitial()) {
    on<LoadVehiclesEvent>(_onLoadVehicles);
    on<SaveVehiclesEvent>(_onSaveVehicles);
    on<AddVehicleEvent>(_onAddVehicle);
    on<DeleteVehicleEvent>(_onDeleteVehicle);
    on<InsertVehicleAtEvent>(_onInsertVehicleAt);
    on<UpdateVehicleEvent>(_onUpdateVehicle);
    on<StartPollingEvent>(_onStartPolling);
    on<StopPollingEvent>(_onStopPolling);
  }

  Future<void> _onLoadVehicles(
    LoadVehiclesEvent event,
    Emitter<VehicleState> emit,
  ) async {
    try {
      emit(VehicleLoading());

      List<Automobile> vehicles;

      if (useDemoData) {
        vehicles = _generateDemoVehicles();
      } else {
        vehicles = await apiService.getVehicles();
      }

      repository.setAll(
        motorcycles: vehicles.whereType<Motorcycle>().toList(),
        cars: vehicles.whereType<Car>().toList(),
        trucks: vehicles.whereType<Truck>().toList(),
      );

      // Cache successful response
      await cacheService.cacheVehicles(vehicles);

      emit(_buildLoadedState());
    } on NetworkUnavailableException {
      // Try to load from cache
      await _loadFromCacheOrEmitError(
        emit,
        NetworkUnavailableState(),
      );
    } on TimeoutException {
      // Try to load from cache
      await _loadFromCacheOrEmitError(
        emit,
        TimeoutState(),
      );
    } on ServerErrorException catch (e) {
      // Try to load from cache
      await _loadFromCacheOrEmitError(
        emit,
        ServerErrorState(statusCode: e.statusCode),
      );
    } catch (e) {
      await _loadFromCacheOrEmitError(
        emit,
        UnknownErrorState('Failed to load vehicles: $e'),
      );
    }
  }

  Future<void> _loadFromCacheOrEmitError(
    Emitter<VehicleState> emit,
    VehicleError errorState,
  ) async {
    try {
      final cached = await cacheService.getCachedVehicles();

      if (cached.isNotEmpty) {
        repository.setAll(
          motorcycles: cached.whereType<Motorcycle>().toList(),
          cars: cached.whereType<Car>().toList(),
          trucks: cached.whereType<Truck>().toList(),
        );

        emit(VehicleLoadedOffline(
          motorcycles: cached.whereType<Motorcycle>().toList(),
          cars: cached.whereType<Car>().toList(),
          trucks: cached.whereType<Truck>().toList(),
        ));
      } else {
        emit(errorState);
      }
    } catch (e) {
      emit(errorState);
    }
  }

  void _onSaveVehicles(
    SaveVehiclesEvent event,
    Emitter<VehicleState> emit,
  ) {
    emit(_buildLoadedState());
  }

  Future<void> _onAddVehicle(
    AddVehicleEvent event,
    Emitter<VehicleState> emit,
  ) async {
    try {
      emit(VehicleLoading());

      if (event.vehicle.id?.isEmpty ?? true) {
        event.vehicle.id = DateTime.now().microsecondsSinceEpoch.toString();
      }

      if (!useDemoData) {
        await apiService.addVehicle(event.vehicle);
      }
      repository.addVehicle(event.vehicle);

      // Cache after add
      final allVehicles = [
        ...repository.motorcycles,
        ...repository.cars,
        ...repository.trucks,
      ];
      await cacheService.cacheVehicles(allVehicles);

      emit(_buildLoadedState());
    } on NetworkUnavailableException {
      await _loadFromCacheOrEmitError(
        emit,
        NetworkUnavailableState(),
      );
    } on TimeoutException {
      await _loadFromCacheOrEmitError(
        emit,
        TimeoutState(),
      );
    } on ServerErrorException catch (e) {
      await _loadFromCacheOrEmitError(
        emit,
        ServerErrorState(statusCode: e.statusCode),
      );
    } catch (e) {
      await _loadFromCacheOrEmitError(
        emit,
        UnknownErrorState('Failed to add vehicle: $e'),
      );
    }
  }

  Future<void> _onDeleteVehicle(
    DeleteVehicleEvent event,
    Emitter<VehicleState> emit,
  ) async {
    try {
      emit(VehicleLoading());

      if (!useDemoData) {
        await apiService.deleteVehicle(event.id);
      }
      repository.deleteVehicle(event.id, event.type);

      // Cache after delete
      final allVehicles = [
        ...repository.motorcycles,
        ...repository.cars,
        ...repository.trucks,
      ];
      await cacheService.cacheVehicles(allVehicles);

      emit(_buildLoadedState());
    } on NetworkUnavailableException {
      await _loadFromCacheOrEmitError(
        emit,
        NetworkUnavailableState(),
      );
    } on TimeoutException {
      await _loadFromCacheOrEmitError(
        emit,
        TimeoutState(),
      );
    } on ServerErrorException catch (e) {
      await _loadFromCacheOrEmitError(
        emit,
        ServerErrorState(statusCode: e.statusCode),
      );
    } catch (e) {
      await _loadFromCacheOrEmitError(
        emit,
        UnknownErrorState('Failed to delete vehicle: $e'),
      );
    }
  }

  Future<void> _onInsertVehicleAt(
    InsertVehicleAtEvent event,
    Emitter<VehicleState> emit,
  ) async {
    try {
      emit(VehicleLoading());

      if (event.vehicle.id?.isEmpty ?? true) {
        event.vehicle.id = DateTime.now().microsecondsSinceEpoch.toString();
      }

      if (!useDemoData) {
        await apiService.addVehicle(event.vehicle);
      }
      repository.insertVehicleAt(event.index, event.vehicle);

      // Cache after insert
      final allVehicles = [
        ...repository.motorcycles,
        ...repository.cars,
        ...repository.trucks,
      ];
      await cacheService.cacheVehicles(allVehicles);

      emit(_buildLoadedState());
    } on NetworkUnavailableException {
      await _loadFromCacheOrEmitError(
        emit,
        NetworkUnavailableState(),
      );
    } on TimeoutException {
      await _loadFromCacheOrEmitError(
        emit,
        TimeoutState(),
      );
    } on ServerErrorException catch (e) {
      await _loadFromCacheOrEmitError(
        emit,
        ServerErrorState(statusCode: e.statusCode),
      );
    } catch (e) {
      await _loadFromCacheOrEmitError(
        emit,
        UnknownErrorState('Failed to insert vehicle: $e'),
      );
    }
  }

  Future<void> _onUpdateVehicle(
    UpdateVehicleEvent event,
    Emitter<VehicleState> emit,
  ) async {
    try {
      emit(VehicleLoading());

      if (!useDemoData) {
        await apiService.updateVehicle(event.updated);
      }
      repository.updateVehicle(event.updated);

      // Cache after update
      final allVehicles = [
        ...repository.motorcycles,
        ...repository.cars,
        ...repository.trucks,
      ];
      await cacheService.cacheVehicles(allVehicles);

      emit(_buildLoadedState());
    } on NetworkUnavailableException {
      await _loadFromCacheOrEmitError(
        emit,
        NetworkUnavailableState(),
      );
    } on TimeoutException {
      await _loadFromCacheOrEmitError(
        emit,
        TimeoutState(),
      );
    } on ServerErrorException catch (e) {
      await _loadFromCacheOrEmitError(
        emit,
        ServerErrorState(statusCode: e.statusCode),
      );
    } catch (e) {
      await _loadFromCacheOrEmitError(
        emit,
        UnknownErrorState('Failed to update vehicle: $e'),
      );
    }
  }

  VehicleLoaded _buildLoadedState() {
    return VehicleLoaded(
      motorcycles: repository.motorcycles,
      cars: repository.cars,
      trucks: repository.trucks,
    );
  }

  Future<void> _onStartPolling(
    StartPollingEvent event,
    Emitter<VehicleState> emit,
  ) async {
    _pollingTimer?.cancel();

    // Initial load
    add(LoadVehiclesEvent());

    // Poll every 30 seconds
    _pollingTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => add(LoadVehiclesEvent()),
    );
  }

  Future<void> _onStopPolling(
    StopPollingEvent event,
    Emitter<VehicleState> emit,
  ) async {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// Generate demo vehicles for testing without an API
  List<Automobile> _generateDemoVehicles() {
    return [
      // Cars
      Car.full(
        'Toyota',
        DateTime(2022, 5, 15),
        'Corolla',
        Engine.full(
          'Toyota',
          DateTime(2022, 4, 10),
          '1.6L 4-cylinder',
          1600,
          4,
          FuelType.gasoline,
        ),
        12345,
        GearType.automatic,
        9876543,
        4,
        2,
        'Silver',
        5,
        true,
      ),
      Car.full(
        'Honda',
        DateTime(2021, 8, 20),
        'Civic',
        Engine.full(
          'Honda',
          DateTime(2021, 7, 15),
          '1.8L 4-cylinder',
          1800,
          4,
          FuelType.gasoline,
        ),
        54321,
        GearType.normal,
        1234567,
        5,
        2,
        'Black',
        5,
        false,
      ),
      Car.full(
        'Mercedes-Benz',
        DateTime(2023, 2, 28),
        'C-Class',
        Engine.full(
          'Mercedes-Benz',
          DateTime(2023, 1, 15),
          '2.0L Turbocharged',
          2000,
          4,
          FuelType.gasoline,
        ),
        11111,
        GearType.automatic,
        4444444,
        5,
        2,
        'Blue',
        5,
        true,
      ),
      // Motorcycles
      Motorcycle.full(
        'Harley-Davidson',
        DateTime(2023, 1, 10),
        'Street 750',
        Engine.full(
          'Harley-Davidson',
          DateTime(2022, 12, 20),
          '750cc V-Twin',
          750,
          2,
          FuelType.gasoline,
        ),
        99999,
        GearType.normal,
        5555555,
        18,
        2.2,
      ),
      Motorcycle.full(
        'Kawasaki',
        DateTime(2022, 9, 5),
        'Ninja 400',
        Engine.full(
          'Kawasaki',
          DateTime(2022, 8, 12),
          '400cc Parallel-Twin',
          400,
          2,
          FuelType.gasoline,
        ),
        77777,
        GearType.automatic,
        3333333,
        17,
        2.0,
      ),
      Motorcycle.full(
        'Yamaha',
        DateTime(2023, 7, 11),
        'YZF-R6',
        Engine.full(
          'Yamaha',
          DateTime(2023, 6, 20),
          '600cc Inline-4',
          600,
          4,
          FuelType.gasoline,
        ),
        66666,
        GearType.normal,
        6666666,
        17,
        2.1,
      ),
      // Trucks
      Truck.full(
        'Volvo',
        DateTime(2021, 3, 18),
        'FH16',
        Engine.full(
          'Volvo',
          DateTime(2021, 2, 25),
          '16L Diesel',
          16000,
          6,
          FuelType.diesel,
        ),
        55555,
        GearType.automatic,
        7777777,
        10,
        3,
        'Red',
        8000.5,
        25000.0,
      ),
      Truck.full(
        'MAN',
        DateTime(2022, 6, 12),
        'TGX',
        Engine.full(
          'MAN',
          DateTime(2022, 5, 20),
          '12L Diesel',
          12000,
          6,
          FuelType.diesel,
        ),
        88888,
        GearType.automatic,
        2222222,
        9,
        2,
        'White',
        7500.0,
        23000.0,
      ),
    ];
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
