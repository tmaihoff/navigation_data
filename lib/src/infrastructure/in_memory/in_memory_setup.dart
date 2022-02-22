// ignore_for_file: avoid_classes_with_only_static_members

import 'package:aviation_entities/airport.dart';
import 'package:aviation_entities/nav_aid.dart';
import 'package:aviation_entities/runway.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation_data/src/domain/airport/airport_repository.dart';
import 'package:navigation_data/src/domain/airport/airport_search_service.dart';
import 'package:navigation_data/src/domain/navaid/nav_aid_repository.dart';
import 'package:navigation_data/src/domain/runway/runway_repository.dart';
import 'package:navigation_data/src/infrastructure/in_memory/airport_in_memory_repository.dart';
import 'package:navigation_data/src/infrastructure/in_memory/nav_aid_in_memory_repository.dart';
import 'package:navigation_data/src/infrastructure/in_memory/runway_in_memory_repository.dart';
import 'package:shared_dart/shared_dart.dart';

class InMemorySetup {
  static Future<void> initialize({
    required List<Airport> airports,
    required List<RunwaySet> runways,
    required List<NavAid> navAids,
  }) async {
    logger.i('initializing in memory data');
    logger.i('registering repositories and services');

    _registerInMemoryAirportRepository(airports);

    _registerInMemoryRunwaysRepository(runways);

    _registerInMemoryNavAidRepository(navAids);

    _registerAirportSearchService();

    logger.i('in memory initializing complete');
  }
}

void _registerInMemoryAirportRepository(List<Airport> airports) {
  final airportRepository = AirportInMemoryRepository(airports);
  GetIt.I.registerSingleton<AirportRepository>(airportRepository);
}

void _registerInMemoryRunwaysRepository(List<RunwaySet> runways) {
  final runwaysRepository = RunwayInMemoryRepository(runways);
  GetIt.I.registerSingleton<RunwayRepository>(runwaysRepository);
}

void _registerInMemoryNavAidRepository(List<NavAid> navAids) {
  final navAidRepository = NavAidInMemoryRepository(navAids);
  GetIt.I.registerSingleton<NavAidRepository>(navAidRepository);
}

void _registerAirportSearchService() {
  GetIt.instance.registerSingleton<AirportSearchService>(
    AirportSearchService(
      GetIt.I.get<AirportRepository>(),
    ),
  );
}
