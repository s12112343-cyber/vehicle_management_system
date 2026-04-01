import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/persistence/persistence_bloc.dart';
import 'bloc/search/search_bloc.dart';
import 'bloc/vehicle/vehicle_bloc.dart';
import 'bloc/vehicle/vehicle_event.dart';
import 'repositories/search_service.dart';
import 'repositories/storage_service.dart';
import 'repositories/vehicle_repository.dart';
import 'screens/Dashboard_screen.dart';
import 'services/vehicle_api_service.dart';
import 'services/cache_service.dart';

void main() {
  final storageService = StorageService();
  final vehicleRepository = VehicleRepository();
  final searchService = SearchService();
  final apiService = VehicleApiService();
  final cacheService = CacheService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => VehicleBloc(
            repository: vehicleRepository,
            apiService: apiService,
            cacheService: cacheService,
          )..add(LoadVehiclesEvent()),
        ),
        BlocProvider(
          create: (_) => SearchBloc(
            repository: vehicleRepository,
            searchService: searchService,
          ),
        ),
        BlocProvider(
          create: (_) => PersistenceBloc(
            storageService: storageService,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Management',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.deepPurple,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      ),
      home: const DashboardPage(),
    );
  }
}
